RFDI_rest = csvread('./data_demo/RFDI_rest.csv');
plot(RFDI_rest(:,1));
pause();

amp = max(RFDI_rest) - min(RFDI_rest);
threshold = 0.04;
RFDI_rest = RFDI_rest(:, amp > threshold);
t = 0.2:0.2:400;
plot(t,mean(RFDI_rest, 2));
title('RFDI mean wave on resting condition');
xlabel('time (ms)');
ylabel('Potential (mV)');
pause();

bg = mean(abs(RFDI_rest(201:1000,:)),1);
MEP = max(RFDI_rest(1001:1400,:)) - min(RFDI_rest(1001:1400,:));
scatter(bg, MEP, 'filled');
pause();

corr(bg, MEP)
cor_test(bg, MEP)
pause();

RFDI_vol = csvread('data_demo/RFDI_vol.csv');
MEP_rest = MEP;
MEP_vol = max(RFDI_vol(1001:1400,:)) - min(RFDI_vol(1001:1400,:));
bar([mean(MEP_rest), mean(MEP_vol)]);
hold all
errorbar([mean(MEP_rest), mean(MEP_vol)], [std(MEP_rest), std(MEP_vol)]);
set(gca, 'XTickLabel', {'rest','voluntary'});
pause();

pkg load statistics
[h,p] = vartest2(MEP_rest, MEP_vol)
[h,p] = ttest2(MEP_rest, MEP_vol)
% 分散が等しいことを仮定しない検定
[h,p] = ttest2(MEP_rest, MEP_vol, 'Vartype', 'unequal')