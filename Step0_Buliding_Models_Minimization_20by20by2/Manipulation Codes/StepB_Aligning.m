% Load XYZ data
function atoms = load_xyz(filename)
    fileID = fopen(filename, 'r');
    num_atoms = str2double(fgetl(fileID));  % Read number of atoms
    fgetl(fileID);  % Skip the comment line
    atoms = cell(num_atoms, 4);  % Initialize cell array to hold atom data
    for i = 1:num_atoms
        line = fgetl(fileID);
        data = textscan(line, '%s %f %f %f');
        atoms{i, 1} = data{1}{1};  % Atom type
        atoms{i, 2} = data{2};     % x-coordinate
        atoms{i, 3} = data{3};     % y-coordinate
        atoms{i, 4} = data{4};     % z-coordinate
    end
    fclose(fileID);
end

% Save XYZ data
function save_xyz(filename, atoms)
    num_atoms = size(atoms, 1);
    fileID = fopen(filename, 'w');
    fprintf(fileID, '%d\n', num_atoms);
    fprintf(fileID, 'Translated coordinates\n');
    for i = 1:num_atoms
        fprintf(fileID, '%s %.6f %.6f %.6f\n', atoms{i, 1}, atoms{i, 2}, atoms{i, 3}, atoms{i, 4});
    end
    fclose(fileID);
end

% Calculate center of mass
function com = calculate_com(atoms)
    num_atoms = size(atoms, 1);
    coordinates = cell2mat(atoms(:, 2:4));
    com = mean(coordinates, 1);
end

% Map coordinates to center of mass
function new_atoms = map_to_com(atoms, com)
    new_atoms = atoms;
    num_atoms = size(atoms, 1);
    for i = 1:num_atoms
        new_atoms{i, 2} = new_atoms{i, 2} - com(1);
        new_atoms{i, 3} = new_atoms{i, 3} - com(2);
        new_atoms{i, 4} = new_atoms{i, 4} - com(3);
    end
end

% Perform Z-direction translation
function new_atoms = translate_z(atoms, h)
    new_atoms = atoms;
    num_atoms = size(atoms, 1);
    for i = 1:num_atoms
        new_atoms{i, 4} = new_atoms{i, 4} + h;
    end
end

% Main script
indenter_file = 'Indenter.xyz';  % Replace with actual filename
tmd_file = 'MoS2_bulk_20by20by2_layers.xyz';  % Replace with actual filename
output_indenter_file = 'indenter_translated.xyz';
output_tmd_file = 'MoS2_translated.xyz';
h = 25.0;  % Replace with desired distance

% Load and process indenter
indenter_atoms = load_xyz(indenter_file);
indenter_com = calculate_com(indenter_atoms);
indenter_atoms_translated = map_to_com(indenter_atoms, indenter_com);
save_xyz(output_indenter_file, indenter_atoms_translated);

% Load and process TMD
tmd_atoms = load_xyz(tmd_file);
tmd_com = calculate_com(tmd_atoms);
tmd_atoms_translated = map_to_com(tmd_atoms, tmd_com);
tmd_atoms_final = translate_z(tmd_atoms_translated, h);
save_xyz(output_tmd_file, tmd_atoms_final);

disp(['Processed files saved as ' output_indenter_file ' and ' output_tmd_file]);