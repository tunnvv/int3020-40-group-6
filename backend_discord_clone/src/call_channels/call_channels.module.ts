import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { ServersModule } from 'src/servers/servers.module';
import { CallChannelsController } from './call_channels.controller';
import { CallChannelsService } from './call_channels.service';
import { CallChannel, CallChannelSchema } from './schemas';

@Module({
  imports: [
    MongooseModule.forFeature([
      { name: CallChannel.name, schema: CallChannelSchema },
    ]),
    ServersModule,
  ],
  controllers: [CallChannelsController],
  providers: [CallChannelsService],
})
export class CallChannelsModule {}
