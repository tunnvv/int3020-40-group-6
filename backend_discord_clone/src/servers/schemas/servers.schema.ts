import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { ApiProperty } from '@nestjs/swagger';
import { Transform, Type } from 'class-transformer';
import mongoose, { Document } from 'mongoose';

import { CallChannel } from 'src/call_channels/schemas';
import { ChatChannel } from 'src/chat_channels/schemas';
import { User } from 'src/users/schemas';

export type ServerDocument = Server & Document;

@Schema()
export class Server {
  @Transform(({ value }) => value.toString())
  _id: string;

  @ApiProperty({ required: true })
  @Prop({ required: true })
  name: string;

  @ApiProperty({ required: false })
  @Prop({
    type: [{ type: mongoose.Schema.Types.ObjectId, ref: 'User' }],
  })
  @Type(() => User)
  members: string[] = [];

  @ApiProperty({ required: false })
  @Prop({
    type: [{ type: mongoose.Schema.Types.ObjectId, ref: 'ChatChannel' }],
  })
  @Type(() => ChatChannel)
  chat_channels: string[] = [];

  @ApiProperty({ required: false })
  @Prop({
    type: [{ type: mongoose.Schema.Types.ObjectId, ref: 'CallChannel' }],
  })
  @Type(() => CallChannel)
  call_channels: string[] = [];
}
export const ServerSchema = SchemaFactory.createForClass(Server);
