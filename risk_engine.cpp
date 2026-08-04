#include <cstdlib>
#include <cmath>

extern "C" {
    // Calculates a risk score out of 100 using a simulated Monte Carlo method
    __declspec(dllexport) double calculate_risk_score(double budget, int market_opportunities, double location_factor) {
        double risk_score = 0.0;
        
        // Simulating heavy Monte Carlo iterations for risk analysis (e.g. 100,000 iterations)
        int iterations = 100000;
        double simulated_failures = 0;

        for (int i = 0; i < iterations; i++) {
            // Generate a random market shock between 0.1 and 2.0
            double random_shock = 0.1 + ((double)rand() / RAND_MAX) * 1.9; 
            
            // Formula to simulate if a business survives a given month
            double survival_chance = (budget / 500000.0) + (market_opportunities * 0.1) + (location_factor * random_shock);
            
            // If survival chance drops below a threshold, count as failure
            if (survival_chance < 2.5) {
                simulated_failures++;
            }
        }

        // Return a risk percentage (higher means more risk)
        risk_score = (simulated_failures / (double)iterations) * 100.0;
        
        // Clamp between 1.0 and 99.0
        if (risk_score < 1.0) risk_score = 1.0;
        if (risk_score > 99.0) risk_score = 99.0;

        return risk_score;
    }
}
