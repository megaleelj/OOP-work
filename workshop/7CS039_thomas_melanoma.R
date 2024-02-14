## Assignment - due 19 Jan 2023



## time - Survival time in days since the operation.
## status - The patients status at the end of the study. 
      ## 1 indicates that they had died from melanoma 
      ## 2 indicates that they were still alive
      ## 3 indicates that they had died from causes unrelated to their melanoma.
## sex - The patients sex; 1=male, 0=female.
## age - Age in years at the time of the operation.
## year - Year of operation.
## thickness - Tumour thickness in mm.
## ulcer - Indicator of ulceration; 1=present, 0=absent.

##libraries 

install.packages("shiny")
install.packages("tidyverse")
install.packages("ggplot2")
install.packages("pastecs")  
install.packages('PerformanceAnalytics')
install.packages("ggstatsplot")


library(dplyr)
library(ggplot2)
library(shiny)
library(tidyverse)
library(pastecs)
library(PerformanceAnalytics)
library(ggstatsplot) # doi:10.21105/joss.03167



#----------------getting data --------------------------------------------------

# Change working directory 
getwd()
setwd("C:/Users/chiat/Desktop/statistics for DS")
getwd()

data <- read.csv('melanoma.csv', header = TRUE, sep = ',')


class(data)

head(data)

dim(data) # number of rows and columns

str(data)



# control + shift + C #comment out multiple lines

# ----------------------Preparing the data in the data set --------------------- 

data <- data[, -1]

dim(data) # number of rows and columns

head(data)

cbind(sapply(data, class))
## changing classes to factor
  ## write reason for factoring 

data$status = factor(data$status)
data$sex = factor(data$sex)
data$ulcer = factor(data$ulcer)

cbind(sapply(data, class))

# Boxplots
par(mfcol = c(1,2))
boxplot(data$age, main = "Age")
boxplot(data$thickness, main = "Thickness")

par(mfcol = c(1,2))
boxplot(data$time, main = "Time") #note to self: why one is out of range
boxplot(data$status, main = "Status")

par(mfcol = c(2,2))
boxplot(data$sex, main = "Sex")
boxplot(data$year, main = "Year")
boxplot(data$ulcer, main = "ulcer")

# show outlier

boxplot.stats(data$age)$out
boxplot.stats(data$thickness)$out
boxplot.stats(data$time)$out

# Outliers removal from age, time and thickness

age_outl <-as.vector(boxplot.stats(data$age)$out)
thickness_outl <-as.vector(boxplot.stats(data$thickness)$out)
time_outl <- as.vector(boxplot.stats(data$time)$out)

data = data[-(which(data$age == age_outl)),]    
data = data[-which(data$thickness == min(thickness_outl)),]
data = data[-which(data$time == min(time_outl)),]

# Boxplots

par(mfcol = c(2,2))
boxplot(data$time, main = "time")
boxplot(data$age, main = "age") # note to self: why [4] is out of range
boxplot(data$thickness, main = "Thickness") #still overlairs

library(ggplot2)

#scatterplot 
ggplot(data, aes(x = age, y = sex, color = sex)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(title = "Scatter plot of Sex vs Age", x = "Age", y = "Sex")

ggplot(data, aes(x = factor(status), y = time)) +
  geom_boxplot(fill = "lightblue", color = "darkblue") +
  labs(title = "Boxplot of Survival Time by Status", x = "Status", y = "Survival Time (days)")


ggplot(data, aes(x = thickness)) +
  geom_histogram(aes(y = ..density..), binwidth = 1, fill = "red") +
  labs(title = "Histogram of Tumour Thickness", x = "Tumour Thickness (mm)", y = "Density")


ggplot(data, aes(x = factor(status))) +
  geom_bar(aes(y = ..count..), fill = "lightblue") +
  labs(title = "Bar plot of Patients Status", x = "Status", y = "Count")

ggplot(data, aes(x = thickness, y = age)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(title = "Linear plot of age vs. Tumour thickness", x = "Tumour thickness (mm)", y = "age (years)")


library(stats)

library(stats)

# Creating the Q-Q plot for survival time and sex
qqnorm(data$time[data$sex == 0],ylab ="time (days)", col="green")
qqline(data$time[data$sex == 0], col="red")
qqnorm(data$age[data$sex == 1],ylab ="age",col="red")
qqline(data$age[data$sex == 1], col="yellow")
qqnorm(data$thickness[data$sex == 1],ylab ="Thickness",col="red")
qqline(data$thickness[data$sex == 1],col="green")

# --------------------------Summary of Data-------------------------------------

## Q1 - summary statistics and graphical summaries

# Appropriate summary statistics for each of the 
# variables in the dataset and a
# commentary on the values of these statistics.



summary(data)
stat.desc(data)
chart.Correlation(data) # note: this can be use to find the correlation 


# time (days) 

summary(data$time)

hist(data$time, main = "Survival time (days)", col = 'green', border = 'black')

plot(time)

boxplot(data$status,
     main="Histogram of Survival time",
     xlab="Status",
     col="darkmagenta",
)

#status  

statusSummarise <- data %>%
  group_by(status) %>%
  summarise(count = n())

statusSummarise

statusCheck <- data %>% 
  ggplot() +
  geom_bar(aes(status), fill = c('#8B475D', '#2E8B57', '#000000')) +
  scale_x_discrete(limit = c("1", "2", "3"), 
                   labels = c('died', 'alive', 'unrealed')) +
  ggtitle('Died/Alive/Unrelated') +
  xlab("") +
  theme_classic()

statusCheck



#sex    

summary.factor(data$sex)



summary(data$sex) # not needed 

sexCheck <- data %>% 
  ggplot() +
  geom_bar(aes(sex), fill = c('#8B475D', '#2E8B57')) +
  scale_x_discrete(limit = c("0", "1"), 
                   labels = c('female', 'male')) +
  ggtitle('Female/Male') +
  xlab("") +
  theme_classic()

sexCheck

data %>%
  ggplot(aes(x = sex)) +
  geom_bar(fill=c('#569842', '#256987'), width = 0.4) +
  scale_x_discrete(limit = c("0", "1"),
                   labels = c('female','male'))
  theme_classic() +
  theme(
    plot.title = element_text(family = "Times New Roman", hjust = 0.5),
    axis.text = element_text(family = "Times New Roman",face = "bold"),
    axis.title = element_text(family = "Times New Roman", face = "bold")
  ) +
  labs(title = " The patients sex", x = "Female/Male", y = "sex count")



#age 

summary(data$age)

boxplot(data$age, main="age")

hist(data$age, main = "Age", col = '#C63265', border = 'black')

ageCheck <- data %>% 
  ggplot() + 
  geom_histogram(aes(age), binwidth = 5, fill = 'blue') + 
  ggtitle('Age') +
  xlab("") +
  theme_classic()

ageCheck


#year 

summary(data$year)

hist(data$year, main = "Year", col = '#7d5698', border = 'black')

yearCheck <- data %>% 
  ggplot() + 
  geom_histogram(aes(year), binwidth = 1, fill = '#6E7B8B') + 
  ggtitle('Year') +
  xlab("") +
  theme_classic()

yearCheck

#thickness   

summary(data$thickness)



ggplot(thickness_outl)

hist(data$thickness, main = "Thickness", col = '#556987', border = 'black')

thicknessCheck <- data %>% 
  ggplot() + 
  geom_histogram(aes(thickness), binwidth = 1, fill = '#785324') + 
  ggtitle('Thickness') +
  xlab("") +
  theme_classic()

thicknessCheck

# ulcer
# ulcer - Indicator of ulceration; 1=present, 0=absent.

table(data$ulcer)

ulcerCheck <- data %>% 
  ggplot() +
  geom_bar(aes(ulcer), fill = c('#8B475D', '#2E8B57')) +
  scale_x_discrete(limit = c("0", "1"), 
                   labels = c('absent', 'present')) +
  ggtitle('Ulcer Absent/Present') +
  xlab("") +
  theme_classic()

ulcerCheck


########################regression analysis and appropriate correlation computations ###################

# time ∼ thickness
# time ∼ age
# thickness ∼ age

##### time and thickness


# cbind(sapply(data, class))

cor.test(data$time, data$thickness, alternative = "less") #Pearson Correlation Test

?ggscatterstats

ggscatterstats(
  data = data,
  x = time, 
  y = thickness,
  type = "parametric"
)

?geom_point
?aes
?plot

plot(data$time, 
     data$thickness,
     pch =16, 
     )

ggplot(data = data) +
  geom_point(mapping = aes(x=time,
                           y=thickness,
                           color=status)) +
  scale_shape_discrete(name="Status",
                          breaks=c("1", "2", "3"),
                          labels=c("A", "b", "c"))

ggplot(data, aes(x=log(time), y=log(thickness))) +
  geom_point() +
  stat_smooth(method = "lm",
              col="#C42126", se=FALSE, size=1)


cor(data$time, data$thickness)

?lm



plot(time ~ thickness,
     data = data, 
     main="Time and Thicknes Col", 
     xlab="time", 
     ylab="thickness", 
     cex=0.75)


points(time ~ thickness, 
      data=data)

LR <- lm(data$thickness ~ data$time)

LR
attributes(LR)

LR$coefficients

summary(LR)

## add regression line

plot(data$time, data$thickness)

abline(LR, col=2, lwd=3)

confint(LR, level = 0.90)

anova(LR)

par(mfrow=c(2,2))
plot(LR) # this is JUST a Diagnostic plot

par(mfrow=c(1,1))



########### time ∼ age


cor.test(data$time, data$age, alternative = "less") #Pearson Correlation Test

?ggscatterstats

ggscatterstats(
  data = data,
  x = time, 
  y = age,
  type = "parametric"
)

?geom_point
?aes
?plot

plot(data$time, 
     data$age,
     pch =16, 
)

ggplot(data = data) +
  geom_point(mapping = aes(x=time,
                           y=age,
                           color=status)) +
  scale_shape_discrete(name="Status",
                       breaks=c("1", "2", "3"),
                       labels=c("A", "b", "c"))

ggplot(data, aes(x=log(time), y=log(age))) +
  geom_point() +
  stat_smooth(method = "lm",
              col="#C42126", se=FALSE, size=1)


cor(data$age, data$time)

?lm



plot(time ~ age,
     data = data, 
     main="Time and Thicknes Col", 
     xlab="time", 
     ylab="thickness", 
     cex=0.75)


points(time ~ age, 
       data=data)

LRTimeAge <- lm(data$age ~ data$time)

LRTimeAge
attributes(LRTimeAge)

LRTimeAge$coefficients

summary(LRTimeAge)

## add regression line

plot(data$time, data$age)

abline(LRTimeAge, col=2, lwd=3)



confint(LRTimeAge, level = 0.90)

anova(LRTimeAge)

par(mfrow=c(2,2))
plot(LRTimeAge) # this is JUST a Diagnostic plot

par(mfrow=c(1,1))

hist(LRTimeAge$residuals, main = "Residuals")





########### thickness ∼ age


cor.test(data$thickness, data$age, alternative = "less") #Pearson Correlation Test

?ggscatterstats

ggscatterstats(
  data = data,
  x = thickness, 
  y = age,
  type = "parametric"
)

?geom_point
?aes
?plot



plot(data$thickness, 
     data$age,
     pch =16, 
)

ggplot(data = data) +
  geom_point(mapping = aes(x=thickness,
                           y=age,
                           color=status)) +
  scale_shape_discrete(name="Status",
                       breaks=c("1", "2", "3"),
                       labels=c("A", "b", "c"))

ggplot(data, aes(x=log(thickness), y=log(age))) +
  geom_point() +
  stat_smooth(method = "lm",
              col="#C42126", se=FALSE, size=1)


cor(data$age, data$thickness)

?lm



plot(thickness ~ age,
     data = data, 
     main="Time and Thicknes Col", 
     xlab="time", 
     ylab="thickness", 
     cex=0.75)


points(thickness ~ age, 
       data=data)

LRThickAge <- lm(data$age ~ data$thickness)

LRThickAge
attributes(LRThickAge)

LRThickAge$coefficients

summary(LRThickAge)

## add regression line

plot(data$thickness, data$age)

abline(LRThickAge, col=2, lwd=3)



confint(LRThickAge, level = 0.90)

anova(LRThickAge)

par(mfrow=c(2,2))
plot(LRThickAge) # this is JUST a Diagnostic plot

par(mfrow=c(1,1))

hist(LRThickAge$residuals, main = "Residuals")


# Q_5 --- Appropriate two sample significance tests for the variables in part (iii) grouped
# by gender.

ggplot(data = data) +
  geom_point(mapping = aes(x=time,
                           y=thickness,
                           color=sex))

ggplot(data = data) +
  geom_point(mapping = aes(x=time,
                           y=age,
                           color=sex))

ggplot(data = data) +
  geom_point(mapping = aes(x=thickness,
                           y=age,
                           color=sex))


par(mfrow=c(2,2))



boxplot(data$thickness ~ data$sex, las=2, names=c("female", "male")) 
boxplot(data$time ~ data$sex, las=2, names=c("female", "male"))
boxplot(data$age ~ data$sex, las=2, names=c("female", "male"))

## compare variance  

?var

var(data$thickness[data$sex=="0"])
var(data$thickness[data$sex=="1"])

var(data$time[data$sex=="0"])
var(data$time[data$sex=="1"])

var(data$age[data$sex=="0"])
var(data$age[data$sex=="1"])

?t.test

t.test(data$thickness ~ data$sex, mu=0, alt="two.sided", conf=0.90,
       var.eq=F, paired=F)


################################################################################

# (vi) For the three variables in part (iii) (grouped by gender as appropriate), 
# QQ-plots
# and a commentary about the underlying distribution of the variables

?geom_qq

ggplot(data, aes(sample=data$thickness, col=data$sex)) +
  geom_qq() +
  geom_qq_line() +
  facet_wrap(~data$sex) +
  theme_minimal()+
  scale_color_brewer(palette = "Dark2")

hist(data$thickness)

ggplot(data, aes(sample=data$time, col=data$sex)) +
  geom_qq() +
  geom_qq_line() +
  facet_wrap(~data$sex) +
  theme_minimal()+
  scale_color_brewer(palette = "Dark2")

hist(data$time)

ggplot(data, aes(sample=data$age, col=data$sex)) +
  geom_qq() +
  geom_qq_line() +
  facet_wrap(~data$sex) +
  theme_minimal()+
  scale_color_brewer(palette = "Dark2")

hist(data$age)

qqnorm(data$thickness)
qqline(data$thickness)  

qqplot(data$time, data$sex)

################################################################################
# note to self: plot year and status#######################


tapply(data$X, data$age, summary) # not appropriate 



