import { ForbiddenException, HttpException, Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { UpdateUserDto } from './dto/update-user.dto';
import { gen_user_id } from 'src/utils/func.backup';
import { JwtService } from '@nestjs/jwt';
import { ShortUserInfo, User, UserDocument } from './schemas';
import { AuthUserDto } from 'src/authentication/dto';
import * as bcrypt from 'bcrypt';

@Injectable()
export class UsersService {
  constructor(
    @InjectModel(User.name) private userModel: Model<UserDocument>,
    private jwtService: JwtService,
  ) {}

  async create(authUserDto: AuthUserDto): Promise<User> {
    try {
      const user = await new this.userModel(authUserDto);

      // Gen and store hashedPassword
      const satlOrRounds = await bcrypt.genSalt();
      user.hashedPassword = await bcrypt.hash(
        authUserDto.password,
        satlOrRounds,
      );

      // Create uid use default name
      let uid = gen_user_id(user.name);
      // If duplicated, create new uid
      while (await this.userModel.findOne({ _uid: uid })) {
        uid = gen_user_id(user.name);
      }
      user._uid = uid;

      await user.save();

      return user;
    } catch (err) {
      if (err.code == 11000) {
        throw new ForbiddenException('User with this email already exists');
      }
      throw new HttpException('Something went wrong', err);
    }
  }

  async findByObjID(id: string): Promise<ShortUserInfo> {
    try {
      const user = await this.userModel.findOne({ _id: id }).lean().exec();
      return {
        _id: user._id,
        _uid: user._uid,
        name: user.name,
        avatar: user.avatar,
        status: user.status,
        bio: user.bio,
        wallpaper: user.wallpaper,
      };
    } catch (err) {
      if (err.code == 404) {
        throw new ForbiddenException('User not found');
      }
      throw new HttpException('Something went wrong', err);
    }
  }

  async findByNameID(uid: string): Promise<User> {
    try {
      const user = await this.userModel.findOne({ _uid: uid }).lean().exec();
      return user;
    } catch (err) {
      if (err.code == 404) {
        throw new ForbiddenException('User not found');
      }
      throw new HttpException('Something went wrong', err);
    }
  }

  async findByEmail(email: string): Promise<User> {
    try {
      const user = await this.userModel.findOne({ email: email }).lean().exec();
      return user;
    } catch (err) {
      if (err.code == 404) {
        throw new ForbiddenException('User not found');
      }
      throw new HttpException('Something went wrong', err);
    }
  }

  async findAll(name?: string): Promise<User[]> {
    const users = await this.userModel
      .find()
      .lean()
      .populate('friends', ['_uid', 'name', 'avatar'])
      .exec();

    if (name) {
      return users.filter((user) => user.name === name);
    }
    return users;
  }

  async getMe(_id: string): Promise<User> {
    try {
      const user = await this.userModel
        .findOne({ _id })
        .lean()
        .populate('friends', ['_id', '_uid', 'avatar', 'wallpaper', 'bio'])
        .populate('servers')
        .exec();

      return user;
    } catch (err) {
      throw new HttpException('Something went wrong', err);
    }
  }

  async update(_id: string, updateUserDto: UpdateUserDto) {
    try {
      const user = await this.userModel.findOne({ _id }).lean().exec();

      // If name changed, must change _uid
      if (updateUserDto.name) {
        // Create new uid
        let uid = gen_user_id(updateUserDto.name);
        // If duplication, create new uid
        while (await this.userModel.findOne({ _uid: uid })) {
          uid = gen_user_id(updateUserDto.name);
        }
        updateUserDto._uid = uid;
      }

      return this.userModel.updateOne({ _id }, updateUserDto);
    } catch (err) {
      throw new HttpException('Something went wrong', err);
    }
  }

  async updateFriendListById(_id: string, friend_id: string) {
    const user = await this.userModel.findOne({ _id }).lean().exec();
    let newFriends = [friend_id].concat(user.friends);
    const tmp = [];
    newFriends = newFriends.reduce((friendListNotDuplicate, element) => {
      if (!tmp.includes(element.toString())) {
        friendListNotDuplicate.push(element);
        tmp.push(element.toString());
      }
      return friendListNotDuplicate;
    }, []);

    return this.userModel.updateOne({ _id }, { friends: newFriends });
  }
}
