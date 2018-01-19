
%%%%Input should be the SpineRegistry file for the called field; Output
%%%%should be a matrix with session number corresponding to row number;
%%%%column 1 is number of new spines; column 2 is number of eliminated
%%%%spines; column 3 is the number of total spines

function spine_counting_ZL 
  %%% first run the session registritration function (written in a seperate
  %%% script, saved to a mat file), it should be able to register the correct
  %%% session number to the corresponding dates of the field being called
  cd 'Z:\People\Nathan\Data\NH005' %%% go to the desired folder, need to change it so that can read the folders sequentially
  load('Imaging Field 1 Spine Registry.mat'); 
   
   Dates = str2double (SpineRegistry.DatesAcquired); %%% covert character format into actual value format
  
  [spineID, day] = size (SpineRegistry.Data) % read the size of spine lifetime matrix, make sure the matrix name is right!
  SpineStatus = SpineRegistry.Data
  RawSpineDynamics_field1 = zeros (day-1, 3); % initiation, create a matrix, column 1 for corresponding session number, column 2 for number of new spines, column 3 for number of eliminated spines
  %%%% need to consider the spine case where it is generated and eliminated
  %%%% so-called short-lived spines
  sessionID = zeros (day, 1); %%% initialization of sessionID matrix/vector
  load('Session_registration.mat') %%% usually should be Session_registration.mat, but if there is missing behavioral data, using _new instead 
  ii = 1;
  
  while ii <= day;
      date = Dates (ii);
      [row, col] = find(Session_registration == date);
      sessionID (ii) = Session_registration (row,2);
      ii = ii + 1;
  end
  jj = 1; 
  while jj <= day-1;
      
     SpineComparisons = SpineStatus(:,jj + 1 )- SpineStatus(:, jj); % column vector substraction
     NumberofNewSpines = sum (SpineComparisons (:,1) == 1); % count number of new spines for this session
     NumberofEliminatedSpines = sum (SpineComparisons (:,1) == -1); % count number of eliminated spines for this session
     RawSpineDynamics_field1 (jj, 2) = NumberofNewSpines;
     RawSpineDynamics_field1 (jj, 3) = NumberofEliminatedSpines; 
     RawSpineDynamics_field1 (jj, 1) = sessionID(jj+1);
     jj = jj + 1;
  end
  cd
  save RawSpineDynamics_field1
  %% make another function called SpineDynamicsSummary_ZL to put normalized data summary in a matrix
  %save the SpineDynamics to the correct folder
  %present bar graphs
  %% this function will be used in another function for the summary of spine dynamics (pooling all current analyzed data together)
end