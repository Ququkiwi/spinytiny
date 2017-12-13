function RedoAnalysis(varargin)


if isempty(varargin)
    if ispc
        foldertouse = 'C:\Users\Komiyama\Desktop\ActivitySummary_UsingRawData';
        cd(foldertouse)
        files = dir(cd);
        for i = 1:length(files)
            if ~isempty(strfind(files(i).name,'Summary')) && isempty(strfind(files(i).name, 'Poly'))
                mouse = regexp(files(i).name, '[ABCDEFGHIJKLMNOPQRSTUVWXYZ]{2}\d+[^_]', 'match');
                mouse = mouse{1};
                date = regexp(files(i).name, '_\d+_', 'match');
                date = date{1}(2:end-1);
                cd(foldertouse)
                load(files(i).name);
                eval(['current_session = ', mouse, '_', date, '_Summary.Session;'])
                AdjustFrequency([mouse, '_', date], current_session, 0);
                clear(files(i).name(1:end-4))
                close all
            end
        end
    elseif isunix
        foldertouse = '/usr/local/lab/People/Nathan/Data';
        cd(foldertouse)
        load('CurrentFilesList')
        files = CurrentFilesList;
        for i = 1:length(files)
            if ~isempty(strfind(files{i}{1},'Summary')) 
                mouse = regexp(files{i}{1}, '[ABCDEFGHIJKLMNOPQRSTUVWXYZ]{2}\d+[^_]', 'match');
                mouse = mouse{1};
                date = regexp(files{i}{1}, '_[0-9]{4,6}_', 'match');
                date = date{1}(2:end-1);
                cd(foldertouse)
                currentsession = files{i}{2};
                AdjustFrequency([mouse, '_', date], currentsession, 0);
            end
        end

    end
else
    for i = 1:length(varargin)
        current_session = varargin{i}.Session;
        mouse = regexp(varargin{i}.Filename, '[ABCDEFGHIJKLMNOPQRSTUVWXYZ]{2}\d+[^_]', 'match');
        mouse = mouse{1};
        date = regexp(varargin{i}.Filename, '_\d+_', 'match');
        date = ['16', date{1}(2:end-1)];
    %     date = varargin{i}.Filename(1:6)
        AdjustFrequency([mouse, '_', date], current_session, 0);
        pause(0.1);
        close all
    end
end
        
        