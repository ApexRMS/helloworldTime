library(rsyncrosim)      # Load SyncroSim R package
myScenario <- scenario()  # Get the SyncroSim scenario that is currently running

# Load RunControl datasheet to be able to set timesteps
runSettings <- datasheet(myScenario, name = "helloworldTime_RunControl")

# Set timesteps - can set to different frequencies if desired
timesteps <- seq(runSettings$MinimumTimestep, runSettings$MaximumTimestep)

# Load scenario's input datasheet from SyncroSim library into R dataframe
myInputDataframe <- datasheet(myScenario,
                              name = "helloworldTime_InputDatasheet")

# Extract model inputs from complete input dataframe
m <- myInputDataframe$m
b <- myInputDataframe$b

# Do calculations
y <- m * timesteps + b

# Setup empty R dataframe ready to accept output in SyncroSim datasheet format
myOutputDataframe <- datasheet(myScenario,
                               name = "helloworldTime_OutputDatasheet")

# Copy output into this R dataframe
myOutputDataframe <- data.frame(Timestep = timesteps, y = y)

# Save this R dataframe back to the SyncroSim library's output datasheet
saveDatasheet(myScenario,
              data=myOutputDataframe,
              name="helloworldTime_OutputDatasheet")