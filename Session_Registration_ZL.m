function Session_Registration_ZL
%%% purpose of this function is to register the correct session ID to the
%%% corresponding date; currently it is based on the file name of behavior
%%% data
% chose the right folder, start to extract the date information from the
% each file
%%% In the case of getting repeated data, usually in the name ending with
%%% "b" (i.e. data_@lever2p_NH_NH004_160319b), create a folder-'repeated
%%% data', then move these files to such folder; this should not happen
%%% frequently, for occasional case can move the repeated data file
%%% manually
mkdir Z:\People\Zhongmin\Data\behavior\NH\NH004 repeated_data ; %%% need to make sure can keep moving on reading the next animal folder
movefile *b.mat repeated_data %%% move the repeated data file to the assigned folder

FileInfo = dir ('*.mat'); %%% Get the information of all files in the current folder
NumberofFiles = numel (FileInfo); %% Get the number of files in the folder



Session_registration = zeros(NumberofFiles,2); %% initialization of the Session_registration matrix
%%% below is to extract the date information from file name
ii = 1; 
session_number = 1;

while ii <= NumberofFiles
filename = FileInfo(ii).name; %% call the file name one by one
ix = strfind (filename, '_');
DateName = filename (ix(end) + 1:end-5); %% extract the sub-string containing date information only
Date = str2num (DateName); %%% convert to actual number, which then can be written to a matrix
Session_registration (ii, 1) = Date; %% write the date into first column
Session_registration (ii, 2) = session_number; %% write the session number into second column
ii = ii + 1; 
session_number = session_number + 1;
end
cd 'Z:\People\Nathan\Data\NH005'
save Session_registration %%% save the matrix to the desired folder
end