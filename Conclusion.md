# 🎾 US Open 2024 Serve Analysis — Conclusion

## 📌 Conclusion

This analysis of the 2024 US Open serve data highlights the consistent dominance of servers across the tournament, with an overall serve win rate of **63.7%**. The leaderboard and visualizations clearly identify the top-performing players, emphasizing the role of **speed** and **placement** in serve success.  

The exploratory CART and Random Forest models confirm these intuitive patterns:  
- **Speed_KMH** and **ServeWidth** emerged as the strongest predictors of point outcomes.  
- **CourtSide** showed minimal influence.  
- Due to class imbalance (servers typically winning), the models defaulted heavily to predicting "server win," achieving ~64% accuracy—essentially replicating the descriptive statistic baseline.  

Importantly, while machine learning confirmed relationships, the **descriptive leaderboard remains the most actionable output**, directly answering the central question: *Who were the most effective servers at the 2024 US Open?*  

---

## 🔑 Key Takeaways
- Servers won nearly two-thirds of points overall.  
- Top players such as **Taylor Fritz, Ben Shelton, and Andrey Rublev** demonstrated standout serving dominance.  
- The models reinforce that **raw speed and width placement drive serve success**, but also illustrate the limits of prediction with only a few basic features.  
- Sometimes, **simple descriptive metrics can be more powerful than complex models** when the primary goal is performance benchmarking rather than outcome prediction.  

---

✅ *This marks the final deliverable for the US Open 2024 Serve Analysis project.*
