--게시판 페이지 처리
	SELECT * FROM 
			(SELECT rownum r ,f.* FROM
								(SELECT * FROM community  ORDER BY idx DESC) f)
		WHERE r BETWEEN #{start} AND #{end}
		
 -- step 1 : idx 내림차순 정렬
 		SELECT * FROM community  ORDER BY idx DESC;
 -- step 2 : rownum 컬럼값 사용
		SELECT rownum r ,f.* FROM
								(SELECT * FROM community  ORDER BY idx DESC) f;
 -- step 3 : 범위를 지정합니다 1페이지의 글이 10개 또는 20개 보이므로 start,end 값을 그 갯수에 따라 지정하기
		SELECT * FROM 
			(SELECT rownum r ,f.* FROM
								(SELECT * FROM community  ORDER BY idx DESC) f)
		WHERE r BETWEEN 1 AND 10; -- 1페이지
	
	SELECT * FROM 
			(SELECT rownum r ,f.* FROM
								(SELECT * FROM community  ORDER BY idx DESC) f)
		WHERE r BETWEEN 11 AND 20; -- 2페이지
		
		SELECT * FROM 
			(SELECT rownum r ,f.* FROM
								(SELECT * FROM community  ORDER BY idx DESC) f)
		WHERE r BETWEEN 101 AND 110; -- 10페이지
		
		
		
-- 새글 저장
		
INSERT INTO community
 			(idx,writer,title,content,ip) 
		VALUES 
			(community_idx_seq.nextval,#{writer},#{title},#{content},#{ip})
			
INSERT INTO community
 			(idx,writer,title,content,ip) 
		VALUES 
			(community_idx_seq.nextval,'wonder','자비를 배푸소서(외전증보판) 1','재미있게 잘 읽었습니다. 다음 편이 궁금해지네요.','13.0.0.1');
			
			
			
			
			
-- 글 수정
		UPDATE community
		SET 
			title=#{title}, content=#{content} ,ip=#{ip}
		WHERE 
			idx=#{idx}	
		
		UPDATE community
		SET 
			title='자비를 배푸소서(외전증보판) 1', content='별로' ,ip='13.0.0.1'
		WHERE 
			idx=258;
-- 글 한개 가져오기
		SELECT * FROM COMMUNITY  WHERE idx=258;
-- 글 삭제			
	DELETE FROM 
 			community 
 		WHERE 
 			idx=#{idx}			
 -- 글 갯수
 	SELECT count(*) FROM community
 -- 글 조회수 증가
 
 	UPDATE community 
		SET 
			READCOUNT = READCOUNT +1 
		WHERE 
			idx = 258;
 -- 메인글의 댓글 갯수 조회 : 댓글 테이블 가서 메인글 번호 idx 를 확인 후 실행
			SELECT count(*) 
 		FROM communityComments 
 		WHERE 
 			mref=50;
 -- 메인글의 댓글 개수 업데이트
 			UPDATE community 
		SET COMMENTCOUNT = 
			(SELECT count(*) 
			 FROM communityComments 
			 WHERE mref=50)
		WHERE idx = 50;
 -- 메인 글의 댓글 목록 가져오기
		SELECT * 
 		FROM communityComments 
 		WHERE 
 			mref=50;
 			
 			
 			
 			