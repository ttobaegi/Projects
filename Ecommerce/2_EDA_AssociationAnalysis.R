#==============#
# SETIING CODE #
#==============#
library(readr)
library(dplyr)
library(tidyverse)
library(arules)
library(arulesViz)

getwd()
setwd("C:\\Users\\USER\\Documents\\Github\\Lpoint")
pr <- read_csv("01.Pruduct.csv")
se1 <- read_csv("02.Search1.csv")
se2 <- read_csv("03.Search2.csv")
cu  <- read_csv("04.Custom.csv")
ses <- read_csv("05.Session.csv")
ma <- read_csv("06.Master.csv")

# 변수명 소문자로 바꾸기
names(pr)<-tolower(names(pr))
names(cu)<-tolower(names(cu))
names(se1)<-tolower(names(se1))
names(se2)<-tolower(names(se2))
names(ses)<-tolower(names(ses))
names(ma)<-tolower(names(ma))

# 고객 아이디 정수화
pr$clnt_id<-as.integer(pr$clnt_id)

# 코드 값 모두 정수화
ma$pd_c <- as.integer(ma$pd_c)
cu$clnt_id <- as.integer(cu$clnt_id)
se1$sess_id <- as.integer(se1$sess_id)
ses$sess_id <- as.integer(ses$sess_id)
pr$pd_c <- as.integer(pr$pd_c)
ma$pd_c <- as.integer(ma$pd_c)
pr$sess_id <- as.integer(pr$sess_id)

#===============#
# PREPROCESSING #
#===============#
# 대분류 잘못 된 것 : 18개 
( a <- ma %>% count(clac1_nm) %>% filter(n<3) )
( b <- ma %>% filter(clac1_nm %in% a$clac1_nm) )  # 밀려서 입력됨
ma <- ma %>% filter(!(clac1_nm %in% a$clac1_nm))  # 제거
b$clac1_nm<-b$clac2_nm; b$clac2_nm<-b$clac3_nm    # 재분류 
ma <- ma %>% rbind(b)
ma %>% count(clac1_nm) %>% print(n=Inf)           # 대분류 37개

#======================#
# ASSOCIATION ANALYSIS #
#======================#

# 고객 구매 정보
a <- pr %>% 
  group_by(pd_c) %>%
  left_join(ma) %>%             # 상품군 정보
  ungroup() %>%
  left_join(ses) %>%            # 날짜 정보
  arrange(sess_dt) %>%
  separate(sess_dt, c("year","date"), sep=4) %>%
  separate(date, c("month","day"), sep=2) %>%
  select(clnt_id:hits_seq, pd_buy_am, pd_buy_ct, 
         clac1_nm, clac2_nm, month) 

# transaction data 만들기

a$clnt_id<-as.character(a$clnt_id)  # 필요변수 문자로 변환
a$clac2_nm<-as.character(a$clac2_nm)

#  split (a,b)
# 첫번째 인수로 주어진 벡터의 데이터
# 두번째 인수로 주어진 벡터의 요인별로 데이터를 구분 list 를 생성
b<- split(a$clac2_nm, a$clnt_id)   # clnt_id 별 구매 상품군 
b<- as(b, "transactions")          # transactions 클래스 변환
b
#b<- sapply(b, unique)              # 중복된 열 제거
b_uniq<- as(b, "transactions")

# inspect() 거래 데이터 조회
inspect(b_uniq[1:20])

# itemFrequency 
# 거래품목(item)별로 거래에서 차지하는 비율(support)
itemFrequency(b_uniq)
itemFrequencyPlot(b_uniq, support=0.05, 
                  main= "지지도 1%이상")
# item frequency plot top 10 : itemFrequencyPlot(,topN)
itemFrequencyPlot(b_uniq, topN = 10, 
                  main = "support top 10 items")


# ASSOCIATION RULE ANALYSIS
b_rule <- apriori(data = b_uniq, 
                  parameter = list(support = 0.01,  
                                   confidence = 0.20,
                                   minlen = 2))
b_rule    # 52 개의 규칙
# 34개의 rule이 2개의 item으로
# 18개의 rule이 3개의 item으로 구성
summary(b_rule)
inspect(b_rule[1:20])

# lift 향상도
# 향상도가 1 보다 크거나(+관계) 작다면(-관계) 
# 우연적 기회(random chance)보다 우수함을 의미
# (X 와 Y 가 서로 독립이면 Lift = 1)
inspect(sort(b_rule, by= "lift"))
# confidence 신뢰도  
# x,y 동시 포함 거래수 / x 를 포함 거래수 
# 신뢰도가 높을 수록 유용한 규칙
inspect(sort(b_rule, by= "confidence")[1:20])
# support 지지도
# x,y 동시 포함 거래수 / 전체 거래수
# 좋은 규칙(빈도가 많은, 구성비가 높은)을 찾거나
# 불필요한 연산을 줄일때(pruning, 가지치기)의 기준
inspect(sort(b_rule, by= "support")[1:20])

# generally, 신뢰도(confidence)와 향상도(lift)가 높은 rule 선호
# IF rule 을 적용하면 기대할 수 있는 매출증가분 관심 있다면,
# 신뢰도(confidence)와 향상도(lift)가 높아도 
# 지지도(support)가 빈약 전체거래 중 아주 드문 거래유형 rule 무시 
# 즉 support 높아서 거래 건수 많아야 매출 이익 기대 가능

c <-inspect(sort(b_rule, by= "lift")) 
class(c)
(b_is<- c[-2] %>% tbl_df() %>% select(lhs:support:lift) )

# IS(interest-support) =  향상도(lift)와 지지도(support)의 곱에 제곱근 
b_is %>% 
  mutate(is=sqrt(support*lift)) %>% arrange(desc(is)) %>% print(n=Inf)
b_is %>% tbl_df()

# VISUALIZATION
# 그래프 안그려질 때 오류 해결 dev.off()
# support top20
plot(b_rule)
plot(sort(b_rule, by= "support")[1:20], method = "grouped")
plot(b_rule, method = "graph", control= list(type="items"),
  vertex.label.cex = 0.7, edge.arrow.size = 3,  edge.arrow.width = 5)

plot(sort(b_rule, by= "support")[1:20], 
     method = "graph", control = list(type="items"))

# lift top20
plot(b_rule)
plot(sort(b_rule, by= "lift")[1:20], method = "grouped")
plot(b_rule, method = "graph", control= list(type="items"),
     vertex.label.cex = 0.7,  edge.arrow.size = 3,  edge.arrow.width = 5)
plot(sort(b_rule, by= "lift")[1:20], 
     method = "graph", control = list(type="items"))



