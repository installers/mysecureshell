package mysecureshell.tests.protocol;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import mysecureshell.tests.protocol.objects.PacketReceiver;
import mysecureshell.tests.protocol.objects.PacketSender;
import mysecureshell.tests.protocol.responses.ResponseStatus;

import org.junit.Assert;

import ch.ethz.ssh2.sftp.Packet;

public final class SshFxpWriteFile
{	
	public ResponseStatus send(InputStream is, OutputStream os, Integer id, byte[] handle, Long offset, byte[] data) throws IOException
	{
		PacketReceiver	receiver;
		PacketSender	sender = new PacketSender(Packet.SSH_FXP_WRITE);
		
		sender.writeUINT32(id);
		sender.writeUINT32(handle.length);
		sender.writeBytes(handle);
		sender.writeUINT64(offset);
		sender.writeUINT32(data.length);
		sender.writeBytes(data);
		sender.write(os);
		receiver = new PacketReceiver().read(is);
		Assert.assertEquals(receiver.getPacketType(), Packet.SSH_FXP_STATUS);
		return new ResponseStatus(id).read(receiver);
	}
}
