tabwindow;

file = 'PALAU_600m.nc';
oldGridFile = '../scheduleForDeletion/Gridpak_ORIG/PALAU_600m.nc';

oldMask = nc_varget(oldGridFile,'mask_rho');
newMask = nc_varget(file,'mask_rho');

h = nc_varget(file,'h');

ilim = [500:600];
jlim = [300:450];
fig(1);clf
imagesc(ilim,jlim,h(jlim,ilim));axis xy
% imagesc(h);axis xy
caxis([0,50])

for jj=300:425;
    for ii=520:595
        if (oldMask(jj,ii)==0)
            h(jj,ii) = 20;
end;end;end


fig(2);clf
imagesc(ilim,jlim,h(jlim,ilim));axis xy
% imagesc(h);axis xy
caxis([0,50])

fig(3);clf;
imagesc(ilim,jlim,h(jlim,ilim).*newMask(jlim,ilim));axis xy
% imagesc(h);axis xy
caxis([0,50])

ilim = [560:567];
jlim = [385:405];

fig(4);clf;
imagesc(ilim,jlim,h(jlim,ilim).*newMask(jlim,ilim));axis xy;colorbar
% imagesc(h);axis xy
caxis([0,400])

h(397,561) = h(395,560);
h(396,561) = h(395,560);
h(395,561) = h(395,560);

h(396,562) = h(396,561) + (1/6)*(h(396,567)-h(396,561));
h(396,563) = h(396,561) + (2/6)*(h(396,567)-h(396,561));
h(396,564) = h(396,561) + (3/6)*(h(396,567)-h(396,561));
h(396,565) = h(396,561) + (4/6)*(h(396,567)-h(396,561));
h(396,566) = h(396,561) + (5/6)*(h(396,567)-h(396,561));

h(397,562) = h(397,561) + (1/6)*(h(397,567)-h(397,561));
h(397,563) = h(397,561) + (2/6)*(h(397,567)-h(397,561));
h(397,564) = h(397,561) + (3/6)*(h(397,567)-h(397,561));
h(397,565) = h(397,561) + (4/6)*(h(397,567)-h(397,561));
h(397,566) = h(397,561) + (5/6)*(h(397,567)-h(397,561));

h(395,565) = h(396,565);

h(395,566) = h(396,566);
h(394,566) = h(396,566);


% h(396,562) = h(396,561) + .25*(h(396,565)-h(396,561));
% h(396,563) = h(396,561) +  .5*(h(396,565)-h(396,561));
% h(396,564) = h(396,561) + .75*(h(396,565)-h(396,561));
% 
% h(397,562) = h(397,561) + .25*(h(397,565)-h(397,561));
% h(397,563) = h(397,561) +  .5*(h(397,565)-h(397,561));
% h(397,564) = h(397,561) + .75*(h(397,565)-h(397,561));

% h(396,562) = h(396,565);
% h(396,563) = h(396,565);
% h(396,564) = h(396,565);
% 
% h(397,562) = h(397,565);
% h(397,563) = h(397,565);
% h(397,564) = h(397,565);

fig(5);clf;
imagesc(ilim,jlim,h(jlim,ilim).*newMask(jlim,ilim));axis xy;colorbar
% imagesc(h);axis xy
caxis([0,400])


ilim = [575:585];
jlim = [450:470];

fig(6);clf;
imagesc(ilim,jlim,h(jlim,ilim).*newMask(jlim,ilim));axis xy;colorbar
% imagesc(h);axis xy
caxis([0,100])

h(458,580) = h(457,580);
h(458,581) = h(457,581);

fig(7);clf;
imagesc(ilim,jlim,h(jlim,ilim).*newMask(jlim,ilim));axis xy;colorbar
% imagesc(h);axis xy
caxis([0,100])


nc_varput(file,'h',h);

