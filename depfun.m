function [fList,pList] = depfun(fname, collate_dir)
[fList,pList] = matlab.codetools.requiredFilesAndProducts(fname);
if nargin > 1
    collate_files(fList, collate_dir);
end
fList = fList';
end