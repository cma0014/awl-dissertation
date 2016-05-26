ARMA Predictor:
	Use armaDriver(model*, data**)
		* Choose model from ProcPwrData.mat
		** Use data from ProcPwrData.mat to evaluate all benchmarks
		

Chaos Predictor:
	Use chaosPredict(data*)
		* Use a time series set from ProcPwrData.mat (A-M)
		** Getting some strange error from for all benchmarks other than A (overall).
		
MARS Predictor:
	Heavily dependent on the ARESLab Toolbox
	Use aresdriver(data*)
		* Use data from ProcPwrData.mat to evaluate all benchmarks
		** Seems the Toolbox is doing some type of normalizing when doing predictions
		
Evals:
	lyapunov(data*)
		* Use a time series set from ProcPwrData.mat (A-M)
			* Generate lyapunov exponent for that time series.
			
	deriv(data*)
		* Use data from ProcPwrData.mat
			* Combines all benchmarks and maps derivitive onto itself.
			** Possibly a slight hint into Chaotic Proof.