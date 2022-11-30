import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { ApiProperty } from '@nestjs/swagger';
import { Transform, Type } from 'class-transformer';
import mongoose, { ObjectId, Document } from 'mongoose';
import { ChatChannel } from 'src/chat_channels/schemas';
import { User } from 'src/users/schemas';

export type NotificationDocument = Notification & Document;

@Schema({ timestamps: true })
export class Notification {
  @Transform(({ value }) => value.toString())
  _id: ObjectId;

  @ApiProperty({ required: false })
  @Prop({ type: mongoose.Types.ObjectId, ref: 'User' })
  @Type(() => User)
  sender: string;

  @ApiProperty({ required: true })
  @Prop({ type: mongoose.Types.ObjectId, ref: 'User' })
  @Type(() => User)
  receiver: string;

  @ApiProperty({ required: true })
  @Prop()
  content: string;

  @ApiProperty({ required: false })
  @Prop({ type: mongoose.Types.ObjectId, ref: 'ChatChannel' })
  @Type(() => ChatChannel)
  chatChannel: string;

  @ApiProperty({ required: false })
  @Prop({ default: false })
  isReply: boolean;
}
export const NotificationSchema = SchemaFactory.createForClass(Notification);
