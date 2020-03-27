package com.carpe.fileupload;

public interface FileCopyStatus {
	public void onDone(String evdId, String ticket);
	public void onProgress(String ticket, long currentCompletedSize, long totalSize);
	public void onError(String evdId, String ticket, Exception e);
}
