package org.kcm.service;

import org.kcm.mapper.Sample1Mapper;
import org.kcm.mapper.Sample2Mapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class SampleTxServiceImpl implements SampleTxService {

	@Setter(onMethod_ = {@Autowired})
	private Sample1Mapper mapper1;
	
	@Setter(onMethod_ = {@Autowired})
	private Sample2Mapper mapper2;
	
	@Transactional
	//이 어노테이션을 쓰면 2개의 테이블에 각각 집어넣는 작업 중 하나라도 오류가 뜨면 둘다 안들어감
	@Override
	public void addData(String value) {
		log.info("Mapper1--------");
		mapper1.insertCol1(value);
		log.info("Mapper2--------");
		mapper2.insertCol2(value);
		log.info("end------------");
	}
}
