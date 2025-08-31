### INSTALL & LOAD REQUIRED PACKAGES ###
install.packages("dplyr")
install.packages("ggplot2")
install.packages("randomForest")
install.packages("rpart")
install.packages("rpart.plot")
install.packages("caTools")
install.packages("readr")  # To read CSV files

library(dplyr)
library(ggplot2)
library(randomForest)
library(rpart)
library(rpart.plot)
library(caTools)
library(readr)

### LOAD DATA FROM LOCAL FILES ###
X2024_usopen_points <- read_csv("Downloads/2024-usopen-points.csv")
X2024_usopen_matches <- read_csv("Downloads/2024-usopen-matches.csv")

### RENAME TO STANDARD NAMES FOR SCRIPTING ###
points <- X2024_usopen_points
matches <- X2024_usopen_matches

### ADD PLAYER NAMES TO EACH POINT ###
players <- matches[, c("match_id", "player1", "player2")]
points <- merge(points, players, by = "match_id", all.x = TRUE)

### CONVERT AND FILTER POINT-LEVEL INFO ###
points$PointWinner <- as.numeric(points$PointWinner)
points$PointServer <- as.numeric(points$PointServer)

points <- points %>%
  filter(!is.na(Speed_KMH), !is.na(ServeWidth), !is.na(PointWinner), !is.na(PointServer)) %>%
  filter(PointWinner %in% c(1, 2), PointServer %in% c(1, 2)) %>%
  mutate(
    ServeResult = as.factor(ifelse(PointWinner == PointServer, 1, 0)),  # 1 if server won point
    CourtSide = ifelse(as.numeric(PointNumber) %% 2 == 0, "Deuce", "Ad"),
    ServerName = ifelse(PointServer == 1, player1, player2)
  )

### REMOVE EXTREME SERVES (JUNK DATA) ###
points <- points %>% filter(Speed_KMH > 100)

### CHECK FINAL CLEANED SERVE RESULT DATA ###
table(points$ServeResult)


set.seed(123)
Sample <- sample.split(points$ServeResult, SplitRatio = 0.75)
Train <- subset(points, Sample == TRUE)
Test <- subset(points, Sample == FALSE)

### BUILD A DECISION TREE MODEL (CART) ###
CART_Model <- rpart(ServeResult ~ Speed_KMH + ServeWidth + CourtSide,
                    data = Train, method = "class")
rpart.plot(CART_Model)

### BUILD A RANDOM FOREST MODEL ###
set.seed(123)
RF_Model <- randomForest(ServeResult ~ Speed_KMH + ServeWidth + CourtSide,
                         data = Train, ntree = 100, importance = TRUE)
print(RF_Model)
importance(RF_Model)
varImpPlot(RF_Model)

### MAKE PREDICTIONS AND EVALUATE ACCURACY ###
Test$RF_Pred <- predict(RF_Model, newdata = Test, type = "class")
confusion_matrix <- table(Predicted = Test$RF_Pred, Actual = Test$ServeResult)
print(confusion_matrix)
accuracy <- mean(Test$RF_Pred == Test$ServeResult)
print(paste("Accuracy:", round(accuracy, 4)))

### CALCULATE BRIER SCORE FOR PROBABILITIES ###
Test$RF_Prob <- predict(RF_Model, newdata = Test, type = "prob")[, 2]
Test$Actual <- as.numeric(as.character(Test$ServeResult))
brier_score <- mean((Test$Actual - Test$RF_Prob)^2)
print(paste("Brier Score:", round(brier_score, 4)))





### AGGREGATE SERVE PERFORMANCE BY PLAYER ###
best_servers <- points %>%
  group_by(ServerName) %>%
  summarise(
    TotalServes = n(),
    ServeWins = sum(as.numeric(as.character(ServeResult))),
    ServeWinRate = round(ServeWins / TotalServes, 3)
  ) %>%
  filter(TotalServes > 50) %>%
  arrange(desc(ServeWinRate))

View(best_servers)

### PLOT TOP 15 BEST SERVERS ###
top15_servers <- best_servers %>% slice_max(order_by = ServeWinRate, n = 15)

ggplot(top15_servers, aes(x = reorder(ServerName, ServeWinRate), y = ServeWinRate)) +
  geom_col(fill = "steelblue") +
  coord_flip() +
  labs(title = "Top 15 Servers by Serve Win % (min 50 serves)",
       x = "Player",
       y = "Serve Win Rate") +
  theme_minimal()
