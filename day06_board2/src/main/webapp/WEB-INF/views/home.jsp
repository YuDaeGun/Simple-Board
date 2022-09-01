<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
	<div>
		<details>
			<summary>SQL</summary>
			<fieldset>
				<pre>
-- day06 테이블 간의 연동 (with FOREIGN KEY)

-- 외래키. 현재 테이블의 컬럼이 다른 테이블의 컬럼을 참조한다 (참조할 수 있는 컬럼은 primary key 또는 unique)
-- [board의 writer]는 반드시 [member의 userid]를 참조해야 한다
-- 즉, writer가 userid에 존재 해야만 글을 작성할 수 있다
----------------------------------------------------------
drop sequence member4_seq;
drop sequence board2_seq;

drop table board2;
drop table member4;

create sequence member4_seq
	start with 1
	maxvalue 999999999
	increment by 1
	nocycle
	nocache;

create sequence board2_seq
	start with 1
	maxvalue 999999999
	increment by 1
	nocycle
	nocache;

create table member4 (
	idx		    number 		    default member4_seq.nextval primary key,
	userid		varchar2(100)	unique not null,
	userpw		varchar2(255)	not null,
	name		varchar2(100)	not null,
	email		varchar2(200)	not null,
	birth		date		    not null,
	deleted		char(1)		    default 'n' check(deleted in ('y', 'n'))
);

create table board2 (
	idx			number			default board2_seq.nextval primary key,
	category	varchar2(100)	check(category in ('공지', '일반', '게임', '등산', '여행')),
	title		varchar2(200)	not null,
	writer		varchar2(100)	,
	content		varchar2(2000)	not null,
	writeDate	date			default sysdate,
	viewCount	number			default 0,
	uploadFile	varchar2(255)	,
	ipaddr		varchar2(20)	not null,
	deleted		char(1)			default 'n' check(deleted in ('y','n')),
	
	constraint board2_member4_fk
	foreign key(writer)
	references member4(userid)
	on delete cascade
);

insert into member4 values (member4_seq.nextval, 'kazama', '3033e4fb0beb3dae78f7ffbeb74f371ab0ffbda30a36ee22f154782e4a9654e75236eaf185812c08ba0e0eb9b86b9630d5d6e1495c4ba8e557abaecf3bd51e85', '카자마 진', 'Kazama_Jin@gmail.com', '1989-03-09', 'n');
insert into member4 values (member4_seq.nextval, 'gae', '093b31ec34990cbb1cd2b9dd6d93418ffe256ef6baacd01faf5aa9afa64f1f6665d23b0084ad949eaac2467c5df6e69a153b0a69e0ca6dc9726fa87cc432e05d', '개똥', 'gaeddong@gmail.com', '1814-04-03', 'n');
insert into member4 values (member4_seq.nextval, 'i', '58007911bf9f66711ef65e807b26c396a2d6fb464f4381520c5d4a575dbb81510f79d35e349604128a771acf2a117a2afdedc012d83b0eb822668aee0def4747', '아이유', 'iu@gmail.com', '2000-12-25', 'n');
insert into member4 values (member4_seq.nextval, 'hong', '3c2cdc0ac23ddf334931145b035d8edb651eacf828db96edc4a2843a91c00e260615743355b4747cff46f1d95f1e2e59fea7ff682c4d673025fb29e624af21a9', '길동', 'honggil@gmail.com', '1444-04-24', 'n');
insert into member4 values (member4_seq.nextval, 'u', 'fc1a22111f8d6f165e4a1100db5e19a0e89ee4cfa1b5ee61ec5320a6afe93b1cea663221489d60c73ce2e49d8bb291cf9754c69e12f5b84116b3397294472d09', '대건', 'udae@gmail.com', '1995-05-12', 'n');
insert into member4 values (member4_seq.nextval, 'gim', '4acf3bfa20988ca398cf9b4d841491038fce806fd31b4c70bfd0890a40388c4077afee22033772663a32fee3c488cfd62f990716a89129cba30ff82aa93aa0ec', '태원', 'gimtae@never.com', '1994-01-01', 'n');
insert into member4 values (member4_seq.nextval, 'sin', 'fbf0c6e68f991f3089175a7acab40ca67b8ce430788de72ee0e9f4789335927536498f72d17ec6d0b82b9d257b328a382a00cad575f54d11dfe0d8e4590aaecf', '지현', 'sinji@gmail.com', '1997-03-12', 'n');
insert into member4 values (member4_seq.nextval, 'nam', '606f61ee547c51d0846d08f86fb31f343a9c0bea5ff898efb8554207c8117ebc29fb271b7a2ea3e041df78e29237c7ccb17ac5e7ff7d6778bafd461f50cbeb0c', '승연', 'namseong@neinom.com', '1997-11-23', 'n');

insert into board2 (category, title, writer, content, ipaddr) values ('공지', '첫번째 게시글', 'u', '대건이 왔다감', '1.1.1.1');
insert into board2 (category, title, writer, content, ipaddr) values ('일반', '일반 게시글', 'nam', '시험삼아 적어봄', '192.168.1.100');
insert into board2 (category, title, writer, content, ipaddr) values ('일반', '일반 게시글', 'gim', 'ㅋㅋㅋㅋㅋ', '192.168.1.100');
insert into board2 (category, title, writer, content, ipaddr) values ('공지', '-- 공지사항 --', 'u', '(대충 중요한 내용)', '1.1.1.1');
insert into board2 (category, title, writer, content, ipaddr) values ('일반', '그냥..', 'nam', '시험삼아 적어봄', '123.456.789.01');
insert into board2 (category, title, writer, content, ipaddr) values ('일반', '우헿헿헿헿헿', 'gim', 'ㅋㅋㅋㅋㅋ', '192.168.1.100');
insert into board2 (category, title, writer, content, ipaddr) values ('게임', '팟원 구함', 'kazama', '1인분 하시는 분', '192.168.1.100');
insert into board2 (category, title, writer, content, ipaddr) values ('여행', '일본 2박 3일', 'i', '티켓이 비싸네', '263.14.563.222');

commit;

select *  from board2;
				</pre>
			</fieldset>
		</details>
		
		<details>
			<summary>구현할 기능</summary>
			<fieldset>
				<ul>
					<li>1. 회원
						<ul>
							<li>1. 회원 가입(패스워드 해시처리)</li>
							<li>2. 로그인/로그아웃</li>
							<li>[이번에 구현 할 기능 : 1, 2]</li>
						</ul>
					</li>
					<li>2. 게시판
						<ul>
							<li>1. 전체 목록</li>
							<li>2. 검색 목록</li>
							<li>3. 게시물 작성(파일 업로드)</li>
							<li>4. 게시물 보기</li>
							<li>   - 5. 게시물 수정</li>
							<li>   - 6. 게시물 삭제</li>
							<li>7. 페이징</li>
							<li>[이번에 구현 할 기능 : 1, 3, 4]</li>
						</ul>
					</li>
					<li>3. 로그인 시에만 접근 가능한 메뉴
						<ul>
							<li>1. 로그아웃</li>
							<li>2. 게시물 작성</li>
							<li>3. 게시물 수정</li>
							<li>4. 게시물 삭제</li>
							<li>[이번에 구현 할 기능 : 1]</li>
						</ul>
					</li>
				</ul>
			</fieldset>
		</details>
	</div>
</section>

</body>
</html>