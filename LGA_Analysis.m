[filename, pathname] = uigetfile('*.*','File Selector');
cd(pathname)
Original = xlsread(filename, '62:157');
Original = transpose(Original(:,:));
for i = 1:size(Original,2)
    row = Original(((Original(:,i)) < 0.90),i);
    if i == 1
        Trim(:,i) = row;
    else
       padadd(Trim, row)
    end
    clear row
end

Doubling_Times = zeros(1,96);
Goodness = zeros(1,96);
for i = 1:size(Trim,2)
    temp_column = Trim(:,i);
    temp_column(isnan(temp_column(:,1)),:)=[];
    [h, gof] = fit(transpose(1:5:size(temp_column,1)*5),temp_column,'exp1');
    Double_time = log(2)/h.b;
    Doubling_Times(1,i) = Double_time;
    Goodness(1,i) = gof.rsquare;
    clear Double_time h temp_column gof
end

Re_Double_times = reshape(Doubling_Times,12,8);
Re_Goodness = reshape(Goodness,12,8);
Re_Double_times = transpose(Re_Double_times);
Re_Goodness = transpose(Re_Goodness);

clear i filename pathname
uisave()