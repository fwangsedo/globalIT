package org.kcm.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.kcm.domain.AttachFileDTO;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;
import org.springframework.http.HttpHeaders;

@Controller
@Log4j
public class UploadController {
	
	@GetMapping("/uploadForm")
	public void uploadForm() {
		log.info("upload Form");
	}
	
	@PostMapping("/uploadFormAction")
	public void uploadFormPost(MultipartFile[] uploadFile, Model model) throws IOException {//왜 굳이 model을 인자로 받는 것인가? 
								//multipart 파일들이 여러개 넘어오므로 배열타입의 객체 name은 input에서와 똑같이 맞춰줌
		String uploadFolder = "c:/upload";
		for(MultipartFile file : uploadFile) {
			log.info("-------------------");
			log.info(file.getOriginalFilename());
			log.info(file.getSize());
			File saveFile = new File(uploadFolder, file.getOriginalFilename());
			try {
				file.transferTo(saveFile);
			}catch (Exception e) {
				log.error(e.getMessage());
			}
		}
	}
	
	@GetMapping("/uploadAjax")
	public void uploadAjax() {
		log.info("upload Ajax");
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value="/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile) {
		String uploadFolder = "c:/upload";
		List<AttachFileDTO> list = new ArrayList<>();
		File uploadPath = new File(uploadFolder, getFolder());
		log.info("uploadPath : " +uploadPath);
		if(uploadPath.exists()==false) {
			uploadPath.mkdirs();
		}
		for(MultipartFile multipartFile: uploadFile) {
			AttachFileDTO attachDTO = new AttachFileDTO();
			log.info("----------------------");
			log.info("upload File Name"+ multipartFile.getOriginalFilename());
			log.info("upload File Size"+ multipartFile.getSize());
			UUID uuid = UUID.randomUUID();
			String uploadFileName = multipartFile.getOriginalFilename();
			attachDTO.setFileName(uploadFileName);
			uploadFileName = uuid.toString()+"_"+uploadFileName;
			File saveFile = new File(uploadPath, uploadFileName);
			try {
				multipartFile.transferTo(saveFile);
				attachDTO.setUuid(uuid.toString()); attachDTO.setUploadPath(getFolder());
				if(checkImageType(saveFile)) {
					attachDTO.setImage(true);
					FileOutputStream thumbnail
					= new FileOutputStream(new File(uploadPath,"s_"+uploadFileName));
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
					thumbnail.close();
				}
				list.add(attachDTO); log.info("attachDTO"+attachDTO);
			}catch (Exception e) {
				log.error(e.getMessage());
			}
		}
		return new ResponseEntity<>(list,HttpStatus.OK);
	}
	
	@GetMapping("/display")
	@ResponseBody//업로드 폴더에 있는 파일이 이미지라면 바이트로 읽어서 ResponseEntity로 보내줌
	public ResponseEntity<byte[]> getFile(String fileName){
		log.info("fileName : "+fileName);
		File file = new File("c:/upload/"+fileName.replace("%5C", "/").replace("%2F", "/"));
		log.info("file : "+file);
		ResponseEntity<byte[]> result = null;
		try {
			log.info("1번째 탐");
			HttpHeaders header = new HttpHeaders();
			log.info(file.toPath());
			log.info(Files.probeContentType(file.toPath()));
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
			log.info("2번째 탐");
		}catch (Exception e) {e.printStackTrace();}
		return result;
	}
	
	@GetMapping(value="/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(String fileName){
		log.info("downloadFile : "+fileName);
		Resource resource = new FileSystemResource("c:/upload/"+fileName);
		if(resource.exists()==false) {return new ResponseEntity<>(HttpStatus.NOT_FOUND);}
		log.info("resource : "+resource);
		String resourceName = resource.getFilename();
		String resourceOriginalName = resourceName.substring(resourceName.indexOf("_")+1);
		log.info("resourceOriginalName : "+resourceOriginalName);
		log.info(resourceName);
		log.info(resourceName.indexOf("_"));
		HttpHeaders headers = new HttpHeaders();
		try {
			headers.add("Content-Disposition","attachment; fileName="+new String(resourceOriginalName.getBytes("UTF-8"),"ISO-8859-1"));
		}catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type){
		log.info("deleteFile : "+fileName);
		File file;
		try {
			file = new File("c:/upload/"+URLDecoder.decode(fileName, "UTF-8"));
			file.delete();
			if(type.equals("image")) {
				String largeFileName = file.getAbsolutePath().replace("s_", "");
				log.info("largeFileName : "+largeFileName);
				file = new File(largeFileName);
				file.delete();
			}
		}catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}
	
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		return str.replace("-", File.separator);
	}
	
	private boolean checkImageType(File file) {
		try {
			String contentType = Files.probeContentType(file.toPath());
			return contentType.startsWith("image");
		}catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
}
