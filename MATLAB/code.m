% Импортируйте данные из csv-файлов
spectra = importdata('spectra.csv');
lambdaStart = importdata('lambda_start.csv');
lambdaDelta = importdata('lambda_delta.csv');
starNames = importdata('star_names.csv');
% Определите константы
LambdaPr = 656.28; %нм
speedOfLight = 299792.458; %км/c

% Определите диапазон длин волн
nObs = size(spectra, 1)
LambdaEnd = lambdaStart + (nObs - 1)*lambdaDelta
lambda = (lambdaStart : lambdaDelta : LambdaEnd)'
nNames = size(starNames,1)
% Рассчитайте скорости звезд относительно Земли
i = 1
sHaVec = linspace(0,0,nNames);
indVec = linspace(0,0,nNames);
speed = linspace(0,0,nNames);
while i <= nNames
    s = spectra(:, i)
    [sHa, ind] = min(s)
    sHaVec(i) = sHa
    indVec(i) = ind
    LambdaHa = lambda(ind)
    speed(i) = (LambdaHa / LambdaPr - 1) * speedOfLight
    i = i+1
end
% Постройте график
fg1 = figure;
i = 1
while i <= nNames
    hold on
    s = spectra(:, i)
    if speed(i) > 0
        plot(lambda, s, "-", 'LineWidth', 3)
    else
        plot(lambda, s, "--", 'LineWidth', 1)
    end
    xlabel('Длина волны, нм')
    ylabel(['Интенсивность, эрг/см^2/с/', char(197)])
    title('Спектры звезд')
    grid on

    i = i + 1 
end
text(lambdaStart + 5, max(s)*6.5, 'Соколов Роман Б01-008')
legend(starNames)
set(fg1, 'visible', 'on');
movaway = starNames(speed > 0)
% Сохраните график
saveas(fg1, 'spectra', 'png')