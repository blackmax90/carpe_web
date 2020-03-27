package com.carpe.fileupload;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;

import org.apache.commons.io.FileUtils;

public class FileCopyWorker implements Runnable {
	private static final int buffer_size = 81920;

	private Thread thread;

	private String evdId;
	private String ticket;
	private String source;
	private String target;

	private FileCopyStatus status;

	public FileCopyWorker(String evdId, String ticket, String srcFile, String destFile, FileCopyStatus status) {
		this.evdId = evdId;
		this.ticket = ticket;
		this.source = srcFile;
		this.target = destFile;
		this.status = status;
	}

	public void startup() {
		thread = new Thread(this);
		thread.start();
	}

	public void run() {
		try {
			File sourceFile = new File(source);
			File targetFile = new File(target);
			File parentFile = targetFile.getParentFile();

			FileUtils.forceMkdir(parentFile);

			BufferedInputStream bin = null;
			BufferedOutputStream bout = null;

			long totalSize = sourceFile.length();
			long currentCompletedSize = 0L;
			
			long cnt = 0L;
			try {
				bin = new BufferedInputStream(new FileInputStream(sourceFile));
				bout = new BufferedOutputStream(new FileOutputStream(targetFile));

				int bytesRead = 0;
				byte[] buffer = new byte[buffer_size];
				while ((bytesRead = bin.read(buffer, 0, buffer_size)) != -1) {
					bout.write(buffer, 0, bytesRead);
					
					currentCompletedSize += ((long) bytesRead);
					
					cnt += 1L;
					if (cnt % 200 == 0 /*현재 16M 단위*/) {
						status.onProgress(ticket, currentCompletedSize, totalSize);
					}
				}

				status.onDone(this.evdId, this.ticket);
			} finally {
				if (bin != null)
					bin.close();
				if (bout != null) {
					bout.flush();
					bout.close();
				}
			}
		} catch (Exception e) {
			status.onError(this.evdId, this.ticket, e);
		}
	}
}
