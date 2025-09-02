## 📊 Results — US Open 2024 Serve Analysis

**Dataset & Cleaning**  
Source: 2024 US Open point-level and match-level data (Jeff Sackmann).  
Filters:
- Drop rows with missing `Speed_KMH`, `ServeWidth`, `PointWinner`, `PointServer`
- Keep valid `PointWinner`/`PointServer` ∈ {1, 2}
- Remove low-speed outliers: `Speed_KMH` ≤ 100

Final sample: **38,997 serve points**  
Server won: **24,840 (63.7%)** • Server lost: **14,157 (36.3%)**  
Overall serve-win rate: **63.7%**

**Leaderboard**  
- `best_servers` table ranks players by serve-win % (min **50** serves).  
- Figure: **Top 15 Servers by Serve Win % (min 50 serves)**.

Artifacts (saved by the script):  
- **Leaderboard CSV:** `artifacts/usopen2024_serve_leaderboard.csv`  
- **Figure:** `artifacts/usopen2024_top15_servers.png`

**Exploratory Models (CART & Random Forest)**  
Features: `Speed_KMH`, `ServeWidth`, `CourtSide`  
- **CART**: for interpretability.  
- **Random Forest (100 trees)**  
  - OOB error: **36.31%** (≈ **63.69%** accuracy)  
  - Test accuracy: **0.637** (≈ overall serve-win rate)  
  - **Baseline:** predicting “server wins” for every point also yields ≈ **0.637** → model behavior matches class imbalance  
  - **Brier score:** **0.3442**  
  - **Variable importance:** `Speed_KMH` and `ServeWidth` dominate; `CourtSide` minor contribution

**Interpretation**  
- Descriptives answer “who serves best” more directly than classification here.  
- Faster + well-placed serves correlate with point wins, but with only 3 features and an imbalanced target, RF essentially approximates the majority class.

**Limitations**  
- Speed cutoff may drop a few true slow second serves.  
- No rebalancing/tuning; models shown for intuition, not SOTA prediction.  
- Not split by draw (Men/Women) yet.

**Key Takeaways**  
- Serve dominance is real: **~63.7%** server win rate overall.  
- Top servers clearly separate on the leaderboard.  
- Among tested features, **speed and width** matter most.

**Reproducibility**  
- Put data in `data/`:  
  - `data/2024-usopen-points.csv`  
  - `data/2024-usopen-matches.csv`  
- Run `USOpen2024TennisServeAnalysisProject.R` (saves artifacts to `artifacts/`).  
- R `sessionInfo()` included below for versions.

## Top 15 Men Servers ##
1. Taylor Fritz
2. Ben Shelton                                                   
3. Andrey Rublev
4. Alexander Zverev
5. Jannik Sinner
6. Tallon Griekspoor
7. Alexei Popyrin
8. Grigor Dimitrov
9. Mattia Bellucci
10. Matteo Berrettini
11. Frances Tiafoe
12. Tomas Machac
13. Stan Wawrinka
14. Jack Draper
15. Nicolas Jarry

## Top 15 Women Servers ##
1. Elena Rybakina
2. Iga Swiatek
3. Donna Vekic
4. Naomi Osaka
5. Anna Karolina Schmiedlova
6. Karolina Muchova
7. Anna Kalinskaya
8. Coco Gauff
9. Aryna Sabalenka
10. Caroline Wozniacki
11. Diana Shnaider
12. Anna Bondar
13. Marta Kostyuk
14. Qinwen Zheng
15. Elise Mertens                                               
