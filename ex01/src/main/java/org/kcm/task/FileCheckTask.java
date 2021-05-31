package org.kcm.task;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.stream.Collector;
import java.util.stream.Collectors;

import org.kcm.domain.BoardAttachVO;
import org.kcm.mapper.BoardAttachMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Component
public class FileCheckTask {
	
	@Setter(onMethod_ = {@Autowired})
	private BoardAttachMapper bMapper;
	
	@Scheduled(cron="* * 0 * * *")//0초를 지날때마다 ==> 1분마다
	public void checkFiles() throws Exception{
		log.warn("file check task run----------");

		List<BoardAttachVO> fileList = bMapper.getOldFiles(); //오늘 기준 어제 폴더에 있는 파일들을 가져옴
		List<Path> fileListPaths = fileList.stream().map(vo -> Paths.get("c:/upload",
				vo.getUploadPath(), vo.getUuid()+"_"+vo.getFileName())).collect(Collectors.toList());
		fileList.stream().filter(vo -> vo.isFileType()==true)
				.map(vo->Paths.get("c:/upload",vo.getUploadPath(),
						"s_"+vo.getUuid()+"_"+vo.getFileName()))
						.forEach(p->fileListPaths.add(p));
		log.warn("==============================");
		fileListPaths.forEach(p->log.warn(p));
		
		File targetDir = Paths.get("c:/upload",getFolderYesterDay()).toFile();
		File[] removeFiles = targetDir.listFiles(file->fileListPaths.contains(file.toPath())==false);
		
		log.warn("------------------------------");
		for(File file : removeFiles) {
			log.warn(file.getAbsoluteFile());
			file.delete();
		}
	}
	
	private String getFolderYesterDay() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, -1);
		String str = sdf.format(cal.getTime());
		return str.replace("-", File.separator);
	}
}
