function [fig,legendEntries,legendTexts] = iceGrowthDiagram(hd,isohumeFlag,ventLog,legLog,legendLocStr,xlimRange,ylimRange,printFig)
%%iceGrowthDiagram
    %Function to plot an ice growth diagram in terms of relative humidity
    %with respect to ice. Returns the figure handle so further
    %modifications are possible.
    %
    %General form: [fig,legendEntries,legendTexts] = iceGrowthDiagram(hd,isohumeFlag,ventLog,legLog,legendLocStr,xlimRang,ylimRange,printFig)
    %
    %Output
    %fig: figure handle for the ice growth diagram
    %legendEntries: figure legend data, used when called by growthDiagramProfile
    %legendTexts: figure legend texts, used when called by growthDiagramProfile
    %
    %Input
    %hd: the habit diagram structure, create with makeGrowthDiagramStruct
    %isohumeFlag: flag for drawing lines of constant RH with respect to water.
    %    1 draws RH lines at 10% intervals from 0 to 100, and at 2.5% and
    %       5% supersaturations with respect to water
    %    2 draws only the water saturation line (RH=100%)
    %    0 and all other values don't plot any isohumes
    %ventLog: logical 1/0 to draw the maximum natural supersaturation line
    %legLog: logical 1/0 to show the legend
    %legendLocStr: legend location string ('southoutside' is default)
    %xlimRange: determines range for x-axis, input as 2-element array (default: [0 0.6])
    %ylimRange: determines range for y-axis (in deg C), input as 2-element
    %    array in increasing order (default: [-56.5 0]). Minimum temperature cannot
    %    be less than -70 degrees Celsius.
    %printFig: 1/0 to save/not save figure as PNG (0 by default)
    %
    %Written by: Daniel Hueholt
    %North Carolina State University
    %Undergraduate Research Assistant at Environment Analytics
    %Edits made as part of HON499: Capstone II
    %Version date: 10/31/2020
    %Last major revision: 10/31/2020
    %
    %See also makeGrowthDiagramStruct, eswLine, ylimitsForIceDiagram
    %

%% Check variables
if ~exist('hd','var')
    crystalLog = 1; otherLog = 1;
    [hd] = makeGrowthDiagramStruct(crystalLog,otherLog); %Instantiate the structure containing all growth diagram information
end
if ~exist('isohumeFlag','var')
    isohumeFlag = 1;
    disp('Isohumes enabled by default')
end
if ~exist('ventLog','var')
    ventLog = 0;
    disp('Ventilation line disabled by default')
end
if ~exist('legLog','var')
    legLog = 1;
    disp('Legend enabled by default')
end
if ~exist('legendLocStr','var')
    legendLocStr = 'southoutside';
    disp('Legend location defaults to below the diagram');
end
if ~exist('xlimRange','var')
    xlimRange = [0 0.6];
    disp('Default ice supersaturation range for x-axis is 0 to 60%')
end
if ~exist('ylimRange','var')
    ylimRange = [-56.5 0];
    disp(['Default temperature range for y-axis is -56.5 to 0' char(176) 'C'])
end
if ~exist('printFig','var')
    printFig = 0;
end

%% Make s-T diagram
fig = figure;
leftColor = [0 0 0]; rightColor = [0 0 0];
set(fig,'defaultAxesColorOrder',[leftColor; rightColor]) %Sets left and right y-axis color

%% Draw the growth types
Tupper = 15; Tlower = -70;
TlineStandardC = Tupper:-0.1:Tlower;
[eswLineData] = eswLine(100,Tlower,Tupper);
plates = patch(hd.Plates.supersatBounds, hd.Plates.TempBounds,hd.Plates.Color);
plates.EdgeColor = 'none';
columnlike = patch(hd.ColumnLike.supersatBounds,hd.ColumnLike.TempBounds,hd.ColumnLike.Color);
columnlike.EdgeColor = 'none';
variousplates = patch(hd.VariousPlates.supersatBounds,hd.VariousPlates.TempBounds,hd.VariousPlates.Color);
variousplates.EdgeColor = 'none';
polycrystalsP1 = patch(hd.PolycrystalsP.supersatBounds(1,:),hd.PolycrystalsP.TempBounds(1,:),hd.PolycrystalsP.Color);
polycrystalsP1.EdgeColor = 'none';
polycrystalsP2 = patch(hd.PolycrystalsP.supersatBounds(2,:),hd.PolycrystalsP.TempBounds(2,:),hd.PolycrystalsP.Color);
polycrystalsP2.EdgeColor = 'none';
polycrystalsC1 = patch(hd.PolycrystalsC.supersatBounds(1,:),hd.PolycrystalsC.TempBounds(1,:),hd.PolycrystalsC.Color);
polycrystalsC1.EdgeColor = 'none';
polycrystalsC2 = patch(hd.PolycrystalsC.supersatBounds(2,:),hd.PolycrystalsC.TempBounds(2,:),hd.PolycrystalsC.Color);
polycrystalsC2.EdgeColor = 'none';
sectorplates1 = patch(hd.SectorPlates.supersatBounds(1,:),hd.SectorPlates.TempBounds(1,:),hd.SectorPlates.Color);
sectorplates1.EdgeColor = 'none';
sectorplates2 = patch(hd.SectorPlates.supersatBounds(2,:),hd.SectorPlates.TempBounds(2,:),hd.SectorPlates.Color);
sectorplates2.EdgeColor = 'none';
sectorplates3 = patch(hd.SectorPlates.supersatBounds(3,:),hd.SectorPlates.TempBounds(3,:),hd.SectorPlates.Color);
sectorplates3.EdgeColor = 'none';
dendrites = patch(hd.Dendrites.supersatBounds,hd.Dendrites.TempBounds,hd.Dendrites.Color);
dendrites.EdgeColor = 'none';

intermediatePlatesP = patch([hd.VariousPlates.supersatBounds(end),hd.VariousPlates.supersatBounds(end),eswLineData(351) eswLineData(371)],[-22 -20 -20 -22],reshape([hd.PolycrystalsP.Color; hd.VariousPlates.Color; hd.VariousPlates.Color; hd.PolycrystalsP.Color],4,[],3));
intermediatePlatesP.EdgeColor = 'none';
intermediateSectorP = patch([eswLineData(351) 0.6 0.6 eswLineData(371)],[-20 -20 -22 -22],reshape([hd.SectorPlates.Color; hd.SectorPlates.Color; hd.PolycrystalsP.Color; hd.PolycrystalsP.Color],4,[],3));
intermediateSectorP.EdgeColor = 'none';

intermediateSPD_floor = patch([hd.Dendrites.supersatBounds(1),hd.Dendrites.supersatBounds(1) hd.Dendrites.supersatBounds(2) hd.Dendrites.supersatBounds(2)], [hd.SectorPlates.TempBounds(5) hd.Dendrites.TempBounds(2) hd.Dendrites.TempBounds(2),hd.SectorPlates.TempBounds(5)],reshape([hd.SectorPlates.Color; hd.Dendrites.Color; hd.Dendrites.Color; hd.SectorPlates.Color],4,[],3));
intermediateSPD_floor.EdgeColor = 'none';
intermediateSPD_wall = patch([hd.SectorPlates.supersatBounds(5),hd.Dendrites.supersatBounds(4) hd.Dendrites.supersatBounds(4) hd.Dendrites.supersatBounds(1)], [hd.SectorPlates.TempBounds(5) hd.SectorPlates.TempBounds(11) hd.Dendrites.TempBounds(3),hd.Dendrites.TempBounds(2)],reshape([hd.SectorPlates.Color; hd.SectorPlates.Color; hd.Dendrites.Color; hd.Dendrites.Color],4,[],3));
intermediateSPD_wall.EdgeColor = 'none';
intermediateSPD_ceiling = patch([hd.Dendrites.supersatBounds(4),hd.Dendrites.supersatBounds(4) hd.SectorPlates.supersatBounds(6) hd.SectorPlates.supersatBounds(9)], [hd.Dendrites.TempBounds(4) hd.SectorPlates.TempBounds(11) hd.SectorPlates.TempBounds(11),hd.Dendrites.TempBounds(4)],reshape([hd.Dendrites.Color; hd.SectorPlates.Color; hd.SectorPlates.Color; hd.Dendrites.Color],4,[],3));
intermediateSPD_ceiling.EdgeColor = 'none';
intermediateSPD_remainingTriangle = patch([hd.SectorPlates.supersatBounds(5),hd.Dendrites.supersatBounds(1) hd.Dendrites.supersatBounds(1)], [hd.SectorPlates.TempBounds(5) hd.Dendrites.TempBounds(1) hd.SectorPlates.TempBounds(5)],reshape([hd.SectorPlates.Color; hd.Dendrites.Color; hd.SectorPlates.Color],3,[],3));
intermediateSPD_remainingTriangle.EdgeColor = 'none';

mixed1 = patch(hd.Mixed.supersatBounds(1,:),hd.Mixed.TempBounds(1,:),hd.Mixed.Color);
mixed1.EdgeColor = 'none';
mixed2 = patch(hd.Mixed.supersatBounds(2,:),hd.Mixed.TempBounds(2,:),hd.Mixed.Color);
mixed2.EdgeColor = 'none';
warmerThanFreezing = patch(hd.warm.supersatBounds(1,:),hd.warm.TempBounds(1,:),hd.warm.Color);
warmerThanFreezing.EdgeColor = 'none';
subsaturated = patch(hd.subsaturated.supersatBounds(1,:),hd.subsaturated.TempBounds(1,:),hd.subsaturated.Color);
subsaturated.EdgeColor = 'none';
if ventLog
    unnaturalVent = patch(hd.unnaturalVent.supersatBounds,hd.unnaturalVent.TempBounds,hd.unnaturalVent.Color);
    unnaturalVent.EdgeColor = 'none';
end
unnatural105 = patch(hd.unnatural105.supersatBounds,hd.unnatural105.TempBounds,hd.unnatural105.Color);
unnatural105.EdgeColor = 'none';
hold on

legendEntries = [plates columnlike sectorplates1 dendrites polycrystalsP1 polycrystalsC1 mixed1]; %Sans subsaturated to make images
legendTexts = {hd.Plates.Habit,hd.ColumnLike.Habit,hd.SectorPlates.Habit,hd.Dendrites.Habit,hd.PolycrystalsP.Habit,hd.PolycrystalsC.Habit,hd.Mixed.Habit};

%% Plot other lines
if isohumeFlag==1 %Draw isohumes wrt water at 10% intervals up to 100%, plus 102.5% and 105%
    
    for rhwc = [90:-10:0, 100, 102.5, 105]
        actHandle = num2str(rhwc);
        actHandleNoPunct = actHandle(actHandle~='.');
        eswLine_Handles.(['p', actHandleNoPunct, 'Num']) = eswLine(rhwc,Tlower,Tupper);
        eswLine_Handles.(['p', actHandleNoPunct, 'Plot']) = plot(eswLine_Handles.(['p', actHandleNoPunct, 'Num']),TlineStandardC);
        if rhwc>100
            eswLine_Handles.(['p', actHandleNoPunct, 'Plot']).LineStyle = '-.';
        elseif rhwc == 100
            eswLine_Handles.(['p', actHandleNoPunct, 'Plot']).LineStyle = '-';
        else
            eswLine_Handles.(['p', actHandleNoPunct, 'Plot']).LineStyle = ':';
        end
        eswLine_Handles.(['p', actHandleNoPunct, 'Plot']).Color = [255/255 230/255 0 0.8];
        eswLine_Handles.(['p', actHandleNoPunct, 'Plot']).LineWidth = 3.2;
    end
    
    legendEntries(end+1) = eswLine_Handles.p100Plot;
    legendEntries(end+1) = eswLine_Handles.p90Plot;
    legendEntries(end+1) = eswLine_Handles.p105Plot;    
    legendTexts{end+1} = 'RH_w = 100%';
    legendTexts{end+1} = 'RH_w (10% intervals)';
    legendTexts{end+1} = 'RH_w (102.5%, 105%)';
    
elseif isohumeFlag==2 %Draw 100% RHw isohume only
    Tupper = 15; Tlower = -70;
    TlineStandardC = Tupper:-0.1:Tlower;
    [eswLineData] = eswLine(100,Tlower,Tupper);
    eswSupersatLineStandard = plot(eswLineData,TlineStandardC);
    eswSupersatLineStandard.Color = [255 230 0]./255;
    eswSupersatLineStandard.LineWidth = 3.2;
    
    legendEntries(end+1) = eswSupersatLineStandard;
    legendTexts{end+1} = 'Water saturation line (T_{ice} = T_{air})';
else
    disp('Isohumes disabled')
end

if ventLog==1 %Approximate maximum supersaturation with ventilation line
    maxVentLine = plot(2.*eswLineData(151:end),TlineStandardC(151:end));
    maxVentLine.Color = [0 26 255]./255;
    maxVentLine.LineWidth = 3.2;
    
    legendEntries(end+1) = maxVentLine;
    legendTexts{end+1} = 'Approximate max natural supersat (with ventilation)';
end

%% Diagram settings
axe = gca;
axe.FontName = 'Lato';
axe.FontSize = 18;

yyaxis right
[zLabels, tempsInRange, rightLimits] = ylimitsForIceDiagram(ylimRange);
axe.YTick = tempsInRange;
yticklabels(zLabels);
ylim(rightLimits)
axe.Layer = 'top';
yLab = ylabel(['Height above 0' char(176) 'C level in m (ICAO standard atmosphere)']);
yLab.FontName = 'Lato Bold';

yyaxis left %Changes what axis dot notation refers
ylim(ylimRange)
xlim(xlimRange)

t = title('Ice growth diagram');
t.FontName = 'Lato Bold';
t.FontSize = 20;
yLab = ylabel(['Temperature in ' char(176) 'C']);
yLab.FontName = 'Lato Bold';
xLab = xlabel('Relative humidity with respect to ice (%)');
xLab.FontName = 'Lato Bold';
axe.YTick = [-70 -60 -55 -50 -40 -30 -22 -20 -18 -16 -14 -12 -10 -8 -6 -4 -2 0 2 4 6 8 10 12];
axe.XTick = [0 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.6];
xTickLabels = {'100' '105' '110' '115' '120' '125' '130' '135' '140' '145' '150' '155' '160'};
xticklabels(xTickLabels);
axe.Layer = 'top'; %Forces tick marks to be displayed over the patch objects
axe.YDir = 'reverse';

if legLog==1
    leg = legend(legendEntries,legendTexts);
    leg.Location = legendLocStr;
    leg.NumColumns = 3;
    leg.FontSize = 14;
else
    %no legend
end

set(gcf, 'PaperUnits','points','PaperPosition', [1 1 1440 849]);
set(gcf,'renderer','Painters')
if printFig == 1
    saveFilename = 'igd_rhi';
    disp(['Saving figure as: ' saveFilename '.png'])
    saveas(gcf,saveFilename,'png');
end

end