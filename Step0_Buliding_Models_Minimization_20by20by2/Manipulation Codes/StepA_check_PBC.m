clear;
close all;

num_atoms = 1200;
box_length = [31.92238 27.64559 26.75659 90.00000 90.00000 90.00000];
box_length_mapped = [31.92238*3 27.64559*3 26.75659 90.00000 90.00000 90.00000];
a = box_length(1);
b = box_length(2);
c = box_length(3);
num_trans = 9;

Mo_code = 77;
S_code = 83;

fidin = fopen('MoS2_10by10by2_trimmed.xyz','r'); 
if fidin == -1
    error('Failed to open the file. Please check!');
end

for i = 1:2
    skip_line = fgetl(fidin);
end

for i = 1:num_atoms
        str = fgetl(fidin);
        num = sscanf(str, '%s %f %f %f', [1,4]);
        if length(num) == 5
           system_coord(i,1) = num(1);
           system_coord(i,2:4) = num(3:5);
        end

        if length(num) == 4
           system_coord(i,1) = num(1);
           system_coord(i,2:4) = num(2:4);
        end
end

xyz = [max(system_coord(:,2)), min(system_coord(:,2)),...
       max(system_coord(:,3)), min(system_coord(:,3)),...
       max(system_coord(:,4)), min(system_coord(:,4))];

centroid = 0.5*[xyz(1)+xyz(2), xyz(3)+xyz(4), xyz(5)+xyz(6)];
        
for i = 1:num_atoms
    system_coord(i,2:4) = system_coord(i,2:4) - centroid;
end

trans_vec = [[0, 0, 0]; ...
             [a, 0, 0]; ...
             [-a, 0, 0]; ...
             [0, b, 0]; ...
             [0, -b, 0]; ...
             [a, b, 0]; ...
             [-a, b, 0]; ...
             [a, -b, 0]; ...
             [-a, -b, 0]];

for i = 1:num_trans
    for j = 1:num_atoms
        System_Coord(num_atoms*(i-1)+j,1) =  system_coord(j,1);
        System_Coord(num_atoms*(i-1)+j,2:4) =  system_coord(j,2:4) + trans_vec(i,:);
    end
end

outfilename_1 = 'MoS2_bulk.xyz';
outfilename_2 = 'MoS2_bulk_mapped.xyz';

fidout_1 = fopen(outfilename_1, 'w');
fidout_2 = fopen(outfilename_2, 'w');

fprintf(fidout_1,'%d\n', num_atoms);
fprintf(fidout_2,'%d\n', num_atoms*num_trans);

fprintf(fidout_1, '%f\t %f\t %f\t %f\t %f\t %f\n', box_length);
fprintf(fidout_2, '%f\t %f\t %f\t %f\t %f\t %f\n', box_length_mapped);

for k = 1:num_atoms
    if system_coord(k,1) == Mo_code
       fprintf(fidout_1, '%s %f\t %f\t %f\n', 'Mo', system_coord(k,2:4));
    end

    if system_coord(k,1) == S_code
       fprintf(fidout_1, '%s %f\t %f\t %f\n', 'S', system_coord(k,2:4));
    end
end

for k = 1:num_atoms*num_trans
    if System_Coord(k,1) == Mo_code
       fprintf(fidout_2, '%s %f\t %f\t %f\n', 'Mo', System_Coord(k,2:4));
    end

    if System_Coord(k,1) == S_code
       fprintf(fidout_2, '%s %f\t %f\t %f\n', 'S', System_Coord(k,2:4));
    end
end

fclose(fidout_1);
fclose(fidout_2);