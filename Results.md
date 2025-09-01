Results

Dataset & Cleaning

Source: 2024 US Open point-level data (points + matches).

Filters applied:

Removed rows with missing Speed_KMH, ServeWidth, PointWinner, PointServer.

Kept only valid point winners/servers in {1, 2}.

Dropped junk serves with Speed_KMH ≤ 100 km/h.

Final sample size (after cleaning): 38,997 serve points

Server won: 24,840 (63.7%)

Server lost: 14,157 (36.3%)

Descriptive Serving Performance

Overall serve win rate across all players: 63.7%.

Leaderboard output:

A full, ranked table is produced in best_servers (min. 50 serves per player).

The plot “Top 15 Servers by Serve Win % (min 50 serves)” visualizes the top performers.

Tip for the repo: Save artifacts so readers can see them without running code:

readr::write_csv(best_servers, "usopen2024_serve_leaderboard.csv")
ggsave("usopen2024_top15_servers.png", width = 8, height = 6, dpi = 300)


Then reference in README:

Leaderboard CSV: usopen2024_serve_leaderboard.csv

Figure:

Exploratory Models (CART & Random Forest)

These models were included to explore whether basic serve features explain outcomes beyond the descriptive stats.

Features used: Speed_KMH, ServeWidth, CourtSide.

Decision Tree (CART): built for interpretability/visualization.

Random Forest (100 trees):

Out-of-bag (OOB) error: 36.31% (~63.69% OOB accuracy).

Test accuracy: 0.637 (consistent with OOB).

Confusion matrix on test showed the model predicted almost exclusively “server won,” reflecting data imbalance (servers usually win).

Brier score (probabilities): 0.3442.

Variable importance (RF):

Speed_KMH and ServeWidth were the top predictors (highest MeanDecreaseGini ~240 each).

CourtSide contributed minimally.

Interpretation

The descriptive metric (serve win %) already answers the central question: who were the most effective servers?

The RF/CART confirm intuitive relationships (faster serves and effective width correlate with wins) but, with only three simple features and an imbalanced target, the classifier largely defaults to the majority class (server wins). That’s expected and acceptable here because the project’s focus is the leaderboard, not point-level loss prediction.

Limitations

Hard cutoff Speed_KMH > 100 is a practical heuristic to drop tracking errors; it may remove a few legitimate slow second serves.

No attempt (here) to rebalance classes or tune thresholds; models were exploratory, not the primary result.

No split by draw (Men/Women) in this core report. (Can be added later if needed.)

Key Takeaways

Serve dominance is real: overall win rate ~63.7%.

Top servers (min 50 serves) stand out clearly in the leaderboard and plot.

Speed and placement matter most among the tested features.

Top 15 Men Servers
1. Taylor Fritz
2. Ben Shelton                                                   
3. Andrey Rublev
4. Alexander Zverev
5. Jannik Sinner
6. Alexei Popyrin
7. Grigor Dimitrov
8. Mattia Bellucci
9. Matteo Berrettini
10. Frances Tiafoe
11. Tomas Machac
12. Stan Wawrinka
13. Jack Draper
14. Nicolas Jarry
15. Ugo Humbert

Top 15 Women Servers
1.                                                     
