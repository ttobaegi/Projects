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

# pr_ma_date
pr %>% 
  group_by(pd_c) %>%
  left_join(ma) %>%             # 상품군 정보
  ungroup() %>%
  left_join(ses) %>%            # 날짜 정보
  arrange(sess_dt) %>%
  separate(sess_dt, c("year","date"), sep=4) %>%
  separate(date, c("month","day"), sep=2) %>%
  select(clnt_id:hits_seq, pd_buy_am, pd_buy_ct, 
         clac1_nm, clac2_nm, month) 
