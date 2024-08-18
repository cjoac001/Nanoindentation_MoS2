close all;
num_atoms = 3026;
num_Mo = 800;
num_S = 1600;
num_C = 626;
num_MoS2 = 2400;
mass_C = 12;

for folder_id=1:51
    
    folderName=sprintf('folder_%d', folder_id);0
    fidin1 = fopen('Trial2_first_frame.xyz','r'); 
    if fidin1== -1
        error('Failed to open the file. Please check!');
    end
    fidin2 = fopen('xmolout','r'); 
    if fidin2== -1
        error('Failed to open the file. Please check!');
    end

    for skip_geo_id= 1:2+num_MoS2
        skip_line_geo = fgetl(fidin1);
    end
    fragment=3028*(folder_id-1);
    for skip_xmolout_id= 1:2402+fragment
        skip_line_xmolout = fgetl(fidin2);
    end
    for carbon_id = 1:num_C
        str1 = fgetl(fidin1);
        num1= sscanf(str1, '%s %f %f %f', [1,4]);
        diamond1(carbon_id,:) = num1;
        str2 = fgetl(fidin2);
        num2= sscanf(str2, '%s %f %f %f', [1,4]);
        diamond2(carbon_id,:) = num2;
    end
    COM1= sum(diamond1(:,2:4))/num_C;
    COM_matrix1(folder_id,:)=COM1;

    COM2= sum(diamond2(:,2:4))/num_C;
    COM_matrix2(folder_id,:)=COM2;

    COM_displacement=COM_matrix2-COM_matrix1;
   

    
    end






  %{  
fidin = fopen('Trial1_first_frame.xyz','r'); 
    if fidin== -1
        error('Failed to open the file. Please check!');
    end


for i = 1:2+num_MoS2
    skip_line_1a = fgetl(fidin_1a);
    skip_line_1b = fgetl(fidin_1b);
    skip_line_2a = fgetl(fidin_2a);
    skip_line_2b = fgetl(fidin_2b);
    skip_line_3a = fgetl(fidin_3a);
    skip_line_3b = fgetl(fidin_3b);
end

% only read C coordinates
for i = 1:num_C
        str_1a = fgetl(fidin_1a);
        num_1a = sscanf(str_1a, '%s %f %f %f', [1,4]);
        diamond_1a(i,:) = num_1a;

        str_1b = fgetl(fidin_1b);
        num_1b = sscanf(str_1b, '%s %f %f %f', [1,4]);
        diamond_1b(i,:) = num_1b;

        str_2a = fgetl(fidin_2a);
        num_2a = sscanf(str_2a, '%s %f %f %f', [1,4]);
        diamond_2a(i,:) = num_2a;

        str_2b = fgetl(fidin_2b);
        num_2b = sscanf(str_2b, '%s %f %f %f', [1,4]);
        diamond_2b(i,:) = num_2b;

        str_3a = fgetl(fidin_3a);
        num_3a = sscanf(str_3a, '%s %f %f %f', [1,4]);
        diamond_3a(i,:) = num_3a;

        str_3b = fgetl(fidin_3b);
        num_3b = sscanf(str_3b, '%s %f %f %f', [1,4]);
        diamond_3b(i,:) = num_3b;
end

COM_1a = sum(diamond_1a(:,2:4))/num_C;
COM_1b = sum(diamond_1b(:,2:4))/num_C;
COM_2a = sum(diamond_2a(:,2:4))/num_C;
COM_2b = sum(diamond_2b(:,2:4))/num_C;
COM_3a = sum(diamond_3a(:,2:4))/num_C;
COM_3b = sum(diamond_3b(:,2:4))/num_C;

disp_trial1 = norm(COM_1b - COM_1a);
disp_trial2 = norm(COM_2b - COM_2a);
disp_trial3 = norm(COM_3b - COM_3a);

Zdisp_trial1 = norm(COM_1b(3) - COM_1a(3));
Zdisp_trial2 = norm(COM_2b(3) - COM_2a(3));
Zdisp_trial3 = norm(COM_3b(3) - COM_3a(3));

Displacement = [disp_trial1; disp_trial2; disp_trial3]
Z_Displacement = [Zdisp_trial1; Zdisp_trial2; Zdisp_trial3]
  %}
