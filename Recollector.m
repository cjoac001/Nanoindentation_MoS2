clear forces;
for folder_id=1:101
    folderName=sprintf('folder_%d', folder_id);
    if isfolder(folderName)
        cd(folderName)
        filename= 'fort.40';

        if isfile(filename)
            fidin=fopen(filename,'r');
            if fidin==-1
                error('Fail to open the file. Please check it again.')
            end
            for skip_id = 1:2401
                skip_line = fgetl(fidin);
            end
           
            for row_id=1:626
                string = fgetl(fidin);
                num = sscanf(string, '%d %s %f %f %f', [1,5]);
                data(row_id,:) = num;
            end
            fclose(fidin);
            x=data(:,3);
            y=data(:,4);
            z=data(:,5);
            fx=sum(x);
            fy=sum(y);
            fz=sum(z);
            
         else
            warning(['File "', fileName, '" does not exist in ', folderName, '.']);
         end
         cd('..');
    else
        warning(['Folder "', folderName, '" does not exist.']);
    end
    forces(folder_id,:)=[fx fy fz];
    clear data fidin filename folderName folder_id row_id skip_id i num num_rows num_skip skip_line string x y z fx fy fz;
    close all;
end
disp(forces)
        


