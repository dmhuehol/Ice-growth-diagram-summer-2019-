%% iceGrowthDiagramTextbook
    % This code produces textbook-quality ice growth diagrams in terms of
    % relative humidity with respect to water, relative humidity with respect to
    % ice, and vapor density excess.
    %
    % General form: call iceGrowthDiagramTextbook at command window. The user
    % will be provided with an input prompt.
    %
    % iceGrowthDiagramTextbook is designed to be replicable, not flexible. The
    % figure drawing is accomplished through a thicket of hardcoding in order
    % to make the appropriate on-figure labels, colors, etc. The code is
    % sectioned off by the moisture variables in a switch/case block. A very
    % limited selection of parameters are modifiable and are described at the
    % start of their respective sections. 
    %
    % For flexible code that produces the high-contrast applied ice growth
    % diagram, see iceGrowthDiagram, iceGrowthDiagramWater, and
    % iceGrowthDiagramVaporExc. To create ice growth profiles from soundings
    % data, see growthDiagramProfile.
    %
    %Written by: Daniel Hueholt
    %North Carolina State University
    %Research Assistant at Environment Analytics
    %Version date: 10/31/2020
    %Last major revision: 10/31/2020
    %
    %Based on concept art originally made in Adobe Illustrator by Dr. Matthew
    %Miller, Senior Research Scholar at Environment Analytics.
    %

function [] = iceGrowthDiagramTextbook()
%% Input
disp('Welcome to the textbook ice growth diagram generator!')
possibleVarPrompt = ['Enter ''water'' to plot in terms of relative humidity with respect to water',...
                     '\nEnter ''ice'' to plot in terms of relative humidity with respect to ice',...
                     '\nEnter ''vde'' to plot in terms of vapor density excess\n'];
castInTermsOf = input(possibleVarPrompt);

if ~isstring(castInTermsOf)
    castInTermsOf = string(castInTermsOf);
end

%% Universal
[hd] = makeGrowthDiagramStruct(1,1);
fig = figure;
leftColor = [0 0 0]; rightColor = [0 0 0];
set(fig,'defaultAxesColorOrder',[leftColor; rightColor]) %Sets left and right y-axis color

Tupper = 15; Tlower = -70;
TlineStandardC = Tupper:-0.1:Tlower;
[eswLineData] = eswLine(100,Tlower,Tupper);
[eswLineDataVde] = iceSupersatToVaporExc(eswLineData,TlineStandardC);

switch castInTermsOf
    case "water"
        %% Ice growth diagram in terms of relative humidity with respect to water
        % Modifiable variables
        xlimRange = [55 105];
        ylimRange = [-56.5 0];
        
        % Draw the growth modes
        Tupper = 15; Tlower = -70;
        TlineStandardC = Tupper:-0.1:Tlower;
        
        plates = patch(hd.Plates.waterBounds, hd.Plates.TempBounds, hd.Plates.TextbookColor);
        plates.EdgeColor = 'none';
        columnlike = patch(hd.ColumnLike.waterBounds,hd.ColumnLike.TempBounds,hd.ColumnLike.TextbookColor);
        columnlike.EdgeColor = 'none';
        variousplates = patch(hd.VariousPlates.waterBounds,hd.VariousPlates.TempBounds,hd.VariousPlates.TextbookColor);
        variousplates.EdgeColor = 'none';
        polycrystalsP1 = patch(hd.PolycrystalsP.waterBounds(1,:),hd.PolycrystalsP.TempBounds(1,:),hd.PolycrystalsP.TextbookColor);
        polycrystalsP1.EdgeColor = 'none';
        polycrystalsP2 = patch(hd.PolycrystalsP.waterBounds(2,:),hd.PolycrystalsP.TempBounds(2,:),hd.PolycrystalsP.TextbookColor);
        polycrystalsP2.EdgeColor = 'none';
        polycrystalsC1 = patch(hd.PolycrystalsC.waterBounds(1,:),hd.PolycrystalsC.TempBounds(1,:),hd.PolycrystalsC.TextbookColor);
        polycrystalsC1.EdgeColor = 'none';
        polycrystalsC2 = patch(hd.PolycrystalsC.waterBounds(2,:),hd.PolycrystalsC.TempBounds(2,:),hd.PolycrystalsC.TextbookColor);
        polycrystalsC2.EdgeColor = 'none';
        sectorplates1 = patch(hd.SectorPlates.waterBounds(1,:),hd.SectorPlates.TempBounds(1,:),hd.SectorPlates.TextbookColor);
        sectorplates1.EdgeColor = 'none';
        sectorplates2 = patch(hd.SectorPlates.waterBounds(2,:),hd.SectorPlates.TempBounds(2,:),hd.SectorPlates.TextbookColor);
        sectorplates2.EdgeColor = 'none';
        sectorplates3 = patch(hd.SectorPlates.waterBounds(3,:),hd.SectorPlates.TempBounds(3,:),hd.SectorPlates.TextbookColor);
        sectorplates3.EdgeColor = 'none';
        dendrites = patch(hd.Dendrites.waterBounds,hd.Dendrites.TempBounds,hd.Dendrites.TextbookColor);
        dendrites.EdgeColor = 'none';
        
        intermediatePlatesP = patch([hd.VariousPlates.waterBounds(end),hd.VariousPlates.waterBounds(end)-3,100 100],[-22 -20 -20 -22],reshape([hd.PolycrystalsP.TextbookColor; hd.VariousPlates.TextbookColor; hd.VariousPlates.TextbookColor; hd.PolycrystalsP.TextbookColor],4,[],3));
        intermediatePlatesP.EdgeColor = 'none';
        intermediateSectorP = patch([100 100 131 131],[-22 -20 -20 -22],reshape([hd.PolycrystalsP.TextbookColor; hd.SectorPlates.TextbookColor; hd.SectorPlates.TextbookColor; hd.PolycrystalsP.TextbookColor],4,[],3));
        intermediateSectorP.EdgeColor = 'none';
        
        intermediateSPD_floor = patch([hd.Dendrites.waterBounds(1),hd.Dendrites.waterBounds(1) hd.Dendrites.waterBounds(2) hd.Dendrites.waterBounds(2)], [hd.SectorPlates.TempBounds(5) hd.Dendrites.TempBounds(2) hd.Dendrites.TempBounds(2),hd.SectorPlates.TempBounds(5)],reshape([hd.SectorPlates.TextbookColor; hd.Dendrites.TextbookColor; hd.Dendrites.TextbookColor; hd.SectorPlates.TextbookColor],4,[],3));
        intermediateSPD_floor.EdgeColor = 'none';
        intermediateSPD_wall = patch([hd.SectorPlates.waterBounds(2,3) hd.SectorPlates.waterBounds(2,2) hd.Dendrites.waterBounds(1) hd.Dendrites.waterBounds(4)], [hd.SectorPlates.TempBounds(3) hd.SectorPlates.TempBounds(2) hd.Dendrites.TempBounds(1) hd.Dendrites.TempBounds(3)],reshape([hd.SectorPlates.TextbookColor; hd.SectorPlates.TextbookColor; hd.Dendrites.TextbookColor; hd.Dendrites.TextbookColor],4,[],3));
        intermediateSPD_wall.EdgeColor = 'none';
        intermediateSPD_ceiling = patch([hd.Dendrites.waterBounds(4),hd.Dendrites.waterBounds(4) hd.SectorPlates.waterBounds(6) hd.SectorPlates.waterBounds(9)], [hd.Dendrites.TempBounds(4) hd.SectorPlates.TempBounds(11) hd.SectorPlates.TempBounds(11),hd.Dendrites.TempBounds(4)],reshape([hd.Dendrites.TextbookColor; hd.SectorPlates.TextbookColor; hd.SectorPlates.TextbookColor; hd.Dendrites.TextbookColor],4,[],3));
        intermediateSPD_ceiling.EdgeColor = 'none';
        intermediateSPD_triangleTop = patch([hd.SectorPlates.waterBounds(2,3) hd.Dendrites.waterBounds(4) hd.Dendrites.waterBounds(1)], [hd.SectorPlates.TempBounds(3) hd.Dendrites.TempBounds(3) hd.SectorPlates.TempBounds(3)], reshape([hd.SectorPlates.TextbookColor; hd.Dendrites.TextbookColor; hd.SectorPlates.TextbookColor],3,[],3));
        intermediateSPD_triangleTop.EdgeColor = 'none';
        intermediateSPD_triangleBottom = patch([hd.SectorPlates.waterBounds(2,2), hd.Dendrites.waterBounds(1), hd.Dendrites.waterBounds(1)], [hd.SectorPlates.TempBounds(2), hd.Dendrites.TempBounds(1), hd.SectorPlates.TempBounds(2)],reshape([hd.SectorPlates.TextbookColor; hd.Dendrites.TextbookColor; hd.SectorPlates.TextbookColor],3,[],3));
        intermediateSPD_triangleBottom.EdgeColor = 'none';
        
        mixed1 = patch(hd.Mixed.waterBounds(1,:),hd.Mixed.TempBounds(1,:),hd.Mixed.TextbookColor);
        mixed1.EdgeColor = 'none';
        
        mixed2 = patch(hd.Mixed.waterBounds(2,:),hd.Mixed.TempBounds(2,:),hd.Mixed.TextbookColor);
        mixed2.EdgeColor = 'none';
        warmerThanFreezing = patch(hd.warm.waterBounds(1,:),hd.warm.TempBounds(1,:),hd.warm.Color);
        warmerThanFreezing.EdgeColor = 'none';
        subsaturated = patch(hd.subsaturated.waterBounds,hd.subsaturated.TempBounds,hd.subsaturated.Color);
        subsaturated.EdgeColor = 'none';
        %unnaturalVent = patch(hd.unnaturalVent.waterBounds,hd.unnaturalVent.TempBounds,hd.unnaturalVent.Color);
        %unnaturalVent.EdgeColor = 'none';
        unnatural105 = patch(hd.unnatural105.waterBounds,hd.unnatural105.TempBounds,hd.unnatural105.Color);
        unnatural105.EdgeColor = 'none';
        hold on
        
        %Draw isohumes
        for rhwc = [90:-10:0, 100, 102.5, 105]
            actHandle = num2str(rhwc);
            actHandleNoPunct = actHandle(actHandle~='.');
            eswLine_Handles.(['p', actHandleNoPunct, 'Plot']) = plot([rhwc rhwc],[-70,0]);
            if rhwc>100
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot']).LineStyle = '-.';
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot']).LineWidth = 0.5;
            elseif rhwc == 100
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot']).LineStyle = '-.';
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot']).LineWidth = 2.5;
            else
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot']).LineStyle = ':';
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot']).LineWidth = 0.5;
            end
            eswLine_Handles.(['p', actHandleNoPunct, 'Plot']).Color = [144 143 143]./255;
        end

        inLineX = [55,96.4635]; inLineY = [-2,-53.2]; %Place left edge of labels along this line
        rhiCount = 1;
        for rhic = 60:-10:-100 %input is an ice supersaturation, -100% ice supersaturation = 0% ice saturation
            if rhic > 0
                actRhiHandle = num2str(rhic);
            else
                actRhiHandle = ['sub',num2str(abs(rhic))];
            end
            esiLine_Handles.(['p', actRhiHandle, 'Num']) = iceSupersatToRH(rhic,TlineStandardC);
            if rhic == 0
                esiLine_Handles.(['p', actRhiHandle, 'Plot1']) = plot(esiLine_Handles.(['p',actRhiHandle,'Num'])(1:351),TlineStandardC(1:351));
                esiLine_Handles.(['p', actRhiHandle, 'Plot2']) = plot(esiLine_Handles.(['p',actRhiHandle,'Num'])(426:end),TlineStandardC(426:end));
                esiLine_Handles.(['p', actRhiHandle, 'Plot1']).LineWidth = 2.5; esiLine_Handles.(['p', actRhiHandle, 'Plot2']).LineWidth = 2.5;
                esiLine_Handles.(['p', actRhiHandle, 'Plot1']).Color = [144 143 143]./255; esiLine_Handles.(['p', actRhiHandle, 'Plot2']).Color = [144 143 143]./255;
            else
                esiLine_Handles.(['p', actRhiHandle, 'Plot']) = plot(esiLine_Handles.(['p',actRhiHandle,'Num']),TlineStandardC);
                esiLine_Handles.(['p', actRhiHandle, 'Plot']).LineWidth = 1.5;
                esiLine_Handles.(['p', actRhiHandle, 'Plot']).LineStyle = ':';
            end
            esiLine_Handles.(['p', actRhiHandle, 'Plot']).Color = [144 143 143]./255;
            if rhic >= -40 %60% RHi (-40% ice supersaturation) is minimum label on textbook diagram
                [xInt,yInt] = polyxpoly(inLineX,inLineY,esiLine_Handles.(['p', actRhiHandle, 'Num']),TlineStandardC);
                labX(rhiCount) = xInt;
                labY(rhiCount) = yInt;
                rhiCount = rhiCount + 1;
            end
        end
        
        % On-figure labels for isohumes and ice-isohumes
        %labelsInLine = plot(inLineX,inLineY); labelsInLine.Color = 'r'; labelsInLine.LineWidth = 1.5;
        labX = flip(labX);
        labY = flip(labY);

        lIce60p = text(labX(1),labY(1),'60% (ice)');
        lIce60p.FontName = 'Lato'; lIce60p.FontSize = 16;
        lIce60p.Rotation = -40;
        lIce70p = text(labX(2),labY(2),'70% (ice)');
        lIce70p.FontName = 'Lato'; lIce70p.FontSize = 16;
        lIce70p.Rotation = -36;
        lIce80p = text(labX(3),labY(3),'80% (ice)');
        lIce80p.FontName = 'Lato'; lIce80p.FontSize = 16;
        lIce80p.Rotation = -32.5;
        lIce90p = text(labX(4),labY(4),'90% (ice)');
        lIce90p.FontName = 'Lato'; lIce90p.FontSize = 16;
        lIce90p.Rotation = -32;
        lIce0 = text(labX(5),labY(5),'100% (ice saturation)');
        lIce0.FontName = 'Lato'; lIce0.FontSize = 18;
        lIce0.Rotation = -35;
        lIce10 = text(labX(6),labY(6),'110% (ice)');
        lIce10.FontName = 'Lato'; lIce10.FontSize = 16;
        lIce10.Rotation = -35;
        lIce20 = text(labX(7),labY(7),'120% (ice)');
        lIce20.FontName = 'Lato'; lIce20.FontSize = 16;
        lIce20.Rotation = -31;
        lIce30 = text(labX(8),labY(8),'130% (ice)');
        lIce30.FontName = 'Lato'; lIce30.FontSize = 16;
        lIce30.Rotation = -31;
        lIce40 = text(labX(9),labY(9),'140% (ice)');
        lIce40.FontName = 'Lato'; lIce40.FontSize = 16;
        lIce40.Rotation = -31;
        lIce50 = text(labX(10),labY(10),'150% (ice)');
        lIce50.FontName = 'Lato'; lIce50.FontSize = 16;
        lIce50.Rotation = -31;
        lIce60 = text(labX(11),labY(11),'160% (ice)');
        lIce60.FontName = 'Lato'; lIce60.FontSize = 16;
        lIce60.Rotation = -32;
        %lVentW = text(107,-6,'Approx. max natural supersat (with ventilation)');
        %lVentW.FontName = 'Lato'; lVentW.FontSize = 13; lVentW.Color = 'k';
        %lVentW.Rotation = 41;
        
        % On-figure labels for growth modes
        lIceSubsaturated = text(72,-10,'Subsaturated with respect to ice, no ice growth');
        lIceSubsaturated.FontName = 'Lato'; lIceSubsaturated.FontSize = 16;
        lFaceW = text(95.2,-6,'Face (column-like)');
        lFaceW.FontName = 'Lato'; lFaceW.FontSize = 16;
        lEdgeW = text(93,-17.65,'Edge (plate-like)');
        lEdgeW.FontName = 'Lato'; lEdgeW.FontSize = 16;
        lCornerSectorTypeW = text(100.65,-19.7,'Corner');
        lCornerSectorTypeW.FontName = 'Lato'; lCornerSectorTypeW.FontSize = 16;
        lCornerSectorSubtypeW = text(100.65,-18.4,'(sector)');
        lCornerSectorSubtypeW.FontName = 'Lato'; lCornerSectorSubtypeW.FontSize = 14;
        lCornerBranchedTypeW = text(102,-15.6,'Corner');
        lCornerBranchedTypeW.FontName = 'Lato'; lCornerBranchedTypeW.FontSize = 16;
        lCornerBranchedSubtypeW = text(102,-14.3,'(branched)');
        lCornerBranchedSubtypeW.FontName = 'Lato'; lCornerBranchedSubtypeW.FontSize = 14;
        lMixedW = text(65,-46.6,'Mixed (polycrystalline, edge, face, and equiaxed)');
        lMixedW.FontName = 'Lato'; lMixedW.FontSize = 16;
        lMixedW.Rotation = -39;
        lPolycrystalsPlatelikeW = text(89,-28,'Platelike polycrystalline');
        lPolycrystalsPlatelikeW.FontName = 'Lato'; lPolycrystalsPlatelikeW.FontSize = 16;
        lPolycrystalsColumnarW = text(77,-50,'Columnar polycrystalline');
        lPolycrystalsColumnarW.FontName = 'Lato'; lPolycrystalsColumnarW.FontSize = 16;
        
        % Diagram settings
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
        yLab.FontName = 'Lato Bold'; yLab.Color = 'k';
        
        yyaxis left %Changes what axis dot notation refers
        ylim(ylimRange)
        xlim(xlimRange)
        
        t = title('Ice growth diagram');
        t.FontName = 'Lato Bold';
        t.FontSize = 20;
        yLab = ylabel(['Temperature in ' char(176) 'C']);
        yLab.FontName = 'Lato Bold';
        xLab = xlabel('Relative humidity with respect to water (%)');
        xLab.FontName = 'Lato Bold';
        axe.YTick = [-70 -60 -55 -50 -40 -30 -22 -20 -18 -16 -14 -12 -10 -8 -6 -4 -2 0 2 4 6 8 10 12];
        axe.XTick = [50 55 60 65 70 75 80 85 90 95 100 105 110 120 130 140 150 160 170];
        axe.Layer = 'top'; %Forces tick marks to be displayed over the patch objects
        axe.YDir = 'reverse';
    case "ice"
        %% Ice growth diagram in terms of relative humidity with respect to ice
        % Check variables
        xlimRange = [-0 0.6];
        ylimRange = [-56.5 0];
        
        % Draw the growth types
        plates = patch(hd.Plates.supersatBounds, hd.Plates.TempBounds,hd.Plates.TextbookColor);
        plates.EdgeColor = 'none';
        columnlike = patch(hd.ColumnLike.supersatBounds,hd.ColumnLike.TempBounds,hd.ColumnLike.TextbookColor);
        columnlike.EdgeColor = 'none';
        variousplates = patch(hd.VariousPlates.supersatBounds,hd.VariousPlates.TempBounds,hd.VariousPlates.TextbookColor);
        variousplates.EdgeColor = 'none';
        polycrystalsP1 = patch(hd.PolycrystalsP.supersatBounds(1,:),hd.PolycrystalsP.TempBounds(1,:),hd.PolycrystalsP.TextbookColor);
        polycrystalsP1.EdgeColor = 'none';
        polycrystalsP2 = patch(hd.PolycrystalsP.supersatBounds(2,:),hd.PolycrystalsP.TempBounds(2,:),hd.PolycrystalsP.TextbookColor);
        polycrystalsP2.EdgeColor = 'none';
        polycrystalsC1 = patch(hd.PolycrystalsC.supersatBounds(1,:),hd.PolycrystalsC.TempBounds(1,:),hd.PolycrystalsC.TextbookColor);
        polycrystalsC1.EdgeColor = 'none';
        polycrystalsC2 = patch(hd.PolycrystalsC.supersatBounds(2,:),hd.PolycrystalsC.TempBounds(2,:),hd.PolycrystalsC.TextbookColor);
        polycrystalsC2.EdgeColor = 'none';
        sectorplates1 = patch(hd.SectorPlates.supersatBounds(1,:),hd.SectorPlates.TempBounds(1,:),hd.SectorPlates.TextbookColor);
        sectorplates1.EdgeColor = 'none';
        sectorplates2 = patch(hd.SectorPlates.supersatBounds(2,:),hd.SectorPlates.TempBounds(2,:),hd.SectorPlates.TextbookColor);
        sectorplates2.EdgeColor = 'none';
        sectorplates3 = patch(hd.SectorPlates.supersatBounds(3,:),hd.SectorPlates.TempBounds(3,:),hd.SectorPlates.TextbookColor);
        sectorplates3.EdgeColor = 'none';
        dendrites = patch(hd.Dendrites.supersatBounds,hd.Dendrites.TempBounds,hd.Dendrites.TextbookColor);
        dendrites.EdgeColor = 'none';
        
        intermediatePlatesP = patch([hd.VariousPlates.supersatBounds(end),hd.VariousPlates.supersatBounds(end),eswLineData(351) eswLineData(371)],[-22 -20 -20 -22],reshape([hd.PolycrystalsP.TextbookColor; hd.VariousPlates.TextbookColor; hd.VariousPlates.TextbookColor; hd.PolycrystalsP.TextbookColor],4,[],3));
        intermediatePlatesP.EdgeColor = 'none';
        intermediateSectorP = patch([eswLineData(351) 0.6 0.6 eswLineData(371)],[-20 -20 -22 -22],reshape([hd.SectorPlates.TextbookColor; hd.SectorPlates.TextbookColor; hd.PolycrystalsP.TextbookColor; hd.PolycrystalsP.TextbookColor],4,[],3));
        intermediateSectorP.EdgeColor = 'none';
        
        intermediateSPD_floor = patch([hd.Dendrites.supersatBounds(1),hd.Dendrites.supersatBounds(1) hd.Dendrites.supersatBounds(2) hd.Dendrites.supersatBounds(2)], [hd.SectorPlates.TempBounds(5) hd.Dendrites.TempBounds(2) hd.Dendrites.TempBounds(2),hd.SectorPlates.TempBounds(5)],reshape([hd.SectorPlates.TextbookColor; hd.Dendrites.TextbookColor; hd.Dendrites.TextbookColor; hd.SectorPlates.TextbookColor],4,[],3));
        intermediateSPD_floor.EdgeColor = 'none';
        intermediateSPD_wall = patch([hd.SectorPlates.supersatBounds(5),hd.Dendrites.supersatBounds(4) hd.Dendrites.supersatBounds(4) hd.Dendrites.supersatBounds(1)], [hd.SectorPlates.TempBounds(5) hd.SectorPlates.TempBounds(11) hd.Dendrites.TempBounds(3),hd.Dendrites.TempBounds(2)],reshape([hd.SectorPlates.TextbookColor; hd.SectorPlates.TextbookColor; hd.Dendrites.TextbookColor; hd.Dendrites.TextbookColor],4,[],3));
        intermediateSPD_wall.EdgeColor = 'none';
        intermediateSPD_ceiling = patch([hd.Dendrites.supersatBounds(4),hd.Dendrites.supersatBounds(4) hd.SectorPlates.supersatBounds(6) hd.SectorPlates.supersatBounds(9)], [hd.Dendrites.TempBounds(4) hd.SectorPlates.TempBounds(11) hd.SectorPlates.TempBounds(11),hd.Dendrites.TempBounds(4)],reshape([hd.Dendrites.TextbookColor; hd.SectorPlates.TextbookColor; hd.SectorPlates.TextbookColor; hd.Dendrites.TextbookColor],4,[],3));
        intermediateSPD_ceiling.EdgeColor = 'none';
        intermediateSPD_remainingTriangle = patch([hd.SectorPlates.supersatBounds(5),hd.Dendrites.supersatBounds(1) hd.Dendrites.supersatBounds(1)], [hd.SectorPlates.TempBounds(5) hd.Dendrites.TempBounds(1) hd.SectorPlates.TempBounds(5)],reshape([hd.SectorPlates.TextbookColor; hd.Dendrites.TextbookColor; hd.SectorPlates.TextbookColor],3,[],3));
        intermediateSPD_remainingTriangle.EdgeColor = 'none';
        mixed1 = patch(hd.Mixed.supersatBounds(1,:),hd.Mixed.TempBounds(1,:),hd.Mixed.TextbookColor);
        mixed1.EdgeColor = 'none';
        mixed2 = patch(hd.Mixed.supersatBounds(2,:),hd.Mixed.TempBounds(2,:),hd.Mixed.TextbookColor);
        mixed2.EdgeColor = 'none';
        warmerThanFreezing = patch(hd.warm.supersatBounds(1,:),hd.warm.TempBounds(1,:),hd.warm.Color);
        warmerThanFreezing.EdgeColor = 'none';
        subsaturated = patch(hd.subsaturated.supersatBounds(1,:),hd.subsaturated.TempBounds(1,:),hd.subsaturated.Color);
        subsaturated.EdgeColor = 'none';
        %unnaturalVent = patch(hd.unnaturalVent.supersatBounds,hd.unnaturalVent.TempBounds,hd.unnaturalVent.Color);
        %unnaturalVent.EdgeColor = 'none';
        unnatural105 = patch(hd.unnatural105.supersatBounds,hd.unnatural105.TempBounds,hd.unnatural105.Color);
        unnatural105.EdgeColor = 'none';
        hold on
        
        % Plot isohumes and ventilation lines
        Tupper = 15; Tlower = -70;
        TlineStandardC = Tupper:-0.1:Tlower;
        for rhwc = [90:-10:0, 100, 102.5, 105]
            actHandle = num2str(rhwc);
            actHandleNoPunct = actHandle(actHandle~='.');
            eswLine_Handles.(['p', actHandleNoPunct, 'Num']) = eswLine(rhwc,Tlower,Tupper);
            if rhwc>100
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot']) = plot(eswLine_Handles.(['p', actHandleNoPunct, 'Num']),TlineStandardC);
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot']).LineStyle = '-.';
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot']).LineWidth = 0.5;
            elseif rhwc == 100
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']) = plot(eswLine_Handles.(['p', actHandleNoPunct, 'Num'])(1:526),TlineStandardC(1:526));
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']) = plot(eswLine_Handles.(['p', actHandleNoPunct, 'Num'])(539:end),TlineStandardC(539:end));
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']).LineStyle = '-'; eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']).LineStyle = '-';
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']).LineWidth = 2.5; eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']).LineWidth = 2.5;
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']).Color = [144 143 143]./255; eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']).Color = [144 143 143]./255;
            else
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot']) = plot(eswLine_Handles.(['p', actHandleNoPunct, 'Num']),TlineStandardC);
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot']).LineStyle = ':';
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot']).LineWidth = 1.5;
            end
            eswLine_Handles.(['p', actHandleNoPunct, 'Plot']).Color = [144 143 143]./255;
        end
        
        %maxVentLine = plot(2.*eswLineData(151:end),TlineStandardC(151:end));
        %maxVentLine.Color = [0 26 255]./255;
        %maxVentLine.LineWidth = 1;
        
        % On-figure labels for growth modes
        lFace = text(0.01,-6,'Face (column-like)');
        lFace.FontName = 'Lato'; lFace.FontSize = 16;
        lEdge = text(0.08,-15.8,'Edge (plate-like)');
        lEdge.FontName = 'Lato'; lEdge.FontSize = 16;
        lCornerBranched = text(0.165,-12.6,'Corner');
        lCornerBranched.FontName = 'Lato'; lCornerBranched.FontSize = 16;
        lCornerBranched.Rotation = 30;
        lCornerBranchedLine2 = text(0.18,-12.6,'(branched)');
        lCornerBranchedLine2.FontName = 'Lato'; lCornerBranchedLine2.FontSize = 14;
        lCornerBranchedLine2.Rotation = 30;
        lCornerSector = text(0.22,-18.03,'Corner');
        lCornerSector.FontName = 'Lato'; lCornerSector.FontSize = 16;
        lCornerSector.Rotation = 30;
        lCornerSectorLine2 = text(0.235,-18.03,'(sector)');
        lCornerSectorLine2.FontName = 'Lato'; lCornerSectorLine2.FontSize = 14;
        lCornerSectorLine2.Rotation = 30;
        lPolycrystalsPlatelike = text(0.26,-32,'Platelike polycrystalline');
        lPolycrystalsPlatelike.FontName = 'Lato'; lPolycrystalsPlatelike.FontSize = 16;
        lPolycrystalsColumnar = text(0.32,-49.5,'Columnar polycrystalline');
        lPolycrystalsColumnar.FontName = 'Lato'; lPolycrystalsColumnar.FontSize = 16;
        lMixed = text(0.02,-19.5,'Mixed (polycrystalline, edge, face, and equiaxed)');
        lMixed.FontName = 'Lato'; lMixed.FontSize = 16;
        lMixed.Rotation = 90;
        
        % On-figure labels for isohumes
        lWater60 = text(0.005,-54.4,'60%');
        lWater60.FontName = 'Lato'; lWater60.FontSize = 16;
        lWater60.Rotation = 34;
        lWater70 = text(0.1161,-48.5,'70%');
        lWater70.FontName = 'Lato'; lWater70.FontSize = 16;
        lWater70.Rotation = 33;
        lWater80 = text(0.236,-44.9,'80%');
        lWater80.FontName = 'Lato'; lWater80.FontSize = 16;
        lWater80.Rotation = 31;
        lWater90 = text(0.3412,-40.9,'90%');
        lWater90.FontName = 'Lato'; lWater90.FontSize = 16;
        lWater90.Rotation = 29;
        lWater100 = text(0.4428,-37.4,'100%');
        lWater100.FontName = 'Lato'; lWater100.FontSize = 16;
        lWater100.Rotation = 26;
        lWater102p5 = text(0.4596,-36,'102.5%');
        lWater102p5.FontName = 'Lato'; lWater102p5.FontSize = 16;
        lWater102p5.Rotation = 26;
        lWater105 = text(0.4742,-34.5,'105% ');
        lWater105.FontName = 'Lato'; lWater105.FontSize = 16;
        lWater105.Rotation = 25;
        lWater105Note = text(0.495,-36.09,'(approx. max ambient supersat)');
        lWater105Note.FontName = 'Lato'; lWater105Note.FontSize = 14;
        lWater105Note.Rotation = 25;
        %lVent = text(0.36,-15.9,'Approx. max natural supersat (with ventilation)');
        %lVent.FontName = 'Lato'; lVent.FontSize = 12;
        %lVent.Rotation = 16;
        
        % Diagram settings
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
    case "vde"
        %% Ice growth diagram in terms of vapor density excess
        % Modifiable variables
        xlimRange = [0 0.351];
        ylimRange = [-56.5 0];
        
        % Draw the growth types
        plates = patch(hd.Plates.vaporExcBounds, hd.Plates.TempBounds, hd.Plates.TextbookColor);
        plates.EdgeColor = 'none';
        columnlike = patch(hd.ColumnLike.vaporExcBounds,hd.ColumnLike.TempBounds,hd.ColumnLike.TextbookColor);
        columnlike.EdgeColor = 'none';
        polycrystalsP1 = patch(hd.PolycrystalsP.vaporExcBounds(1,:),hd.PolycrystalsP.TempBounds(1,:),hd.PolycrystalsP.TextbookColor);
        polycrystalsP1.EdgeColor = 'none';
        polycrystalsP2 = patch(hd.PolycrystalsP.vaporExcBounds(2,:),hd.PolycrystalsP.TempBounds(2,:),hd.PolycrystalsP.TextbookColor);
        polycrystalsP2.EdgeColor = 'none';
        polycrystalsC1 = patch(hd.PolycrystalsC.vaporExcBounds(1,:),hd.PolycrystalsC.TempBounds(1,:),hd.PolycrystalsC.TextbookColor);
        polycrystalsC1.EdgeColor = 'none';
        polycrystalsC2 = patch(hd.PolycrystalsC.vaporExcBounds(2,:),hd.PolycrystalsC.TempBounds(2,:),hd.PolycrystalsC.TextbookColor);
        polycrystalsC2.EdgeColor = 'none';
        sectorplates1 = patch(hd.SectorPlates.vaporExcBounds(1,:),hd.SectorPlates.TempBounds(1,:),hd.SectorPlates.TextbookColor);
        sectorplates1.EdgeColor = 'none';
        sectorplates2 = patch(hd.SectorPlates.vaporExcBounds(2,:),hd.SectorPlates.TempBounds(2,:),hd.SectorPlates.TextbookColor);
        sectorplates2.EdgeColor = 'none';
        sectorplates3 = patch(hd.SectorPlates.vaporExcBounds(3,:),hd.SectorPlates.TempBounds(3,:),hd.SectorPlates.TextbookColor);
        sectorplates3.EdgeColor = 'none';
        dendrites = patch(hd.Dendrites.vaporExcBounds,hd.Dendrites.TempBounds,hd.Dendrites.TextbookColor);
        dendrites.EdgeColor = 'none';
        variousplates = patch(hd.VariousPlates.vaporExcBounds,hd.VariousPlates.TempBounds,hd.VariousPlates.TextbookColor);
        variousplates.EdgeColor = 'none';
        
        intermediatePlatesP = patch([hd.VariousPlates.vaporExcBounds(end),hd.VariousPlates.vaporExcBounds(end)-3,eswLineDataVde(351),eswLineDataVde(371)],[-22 -20 -20 -22],reshape([hd.PolycrystalsP.TextbookColor; hd.VariousPlates.TextbookColor; hd.VariousPlates.TextbookColor; hd.PolycrystalsP.TextbookColor],4,[],3));
        intermediatePlatesP.EdgeColor = 'none';
        intermediateSectorP = patch([eswLineDataVde(351) 0.9113 0.9113 eswLineDataVde(371)],[-20 -20 -22 -22],reshape([hd.SectorPlates.TextbookColor; hd.SectorPlates.TextbookColor; hd.PolycrystalsP.TextbookColor; hd.PolycrystalsP.TextbookColor],4,[],3));
        intermediateSectorP.EdgeColor = 'none';
        
        intermediateSPD_floor = patch([hd.Dendrites.vaporExcBounds(1),hd.Dendrites.vaporExcBounds(1) hd.Dendrites.vaporExcBounds(2) hd.Dendrites.vaporExcBounds(2)], [hd.SectorPlates.TempBounds(5) hd.Dendrites.TempBounds(2) hd.Dendrites.TempBounds(2),hd.SectorPlates.TempBounds(5)],reshape([hd.SectorPlates.TextbookColor; hd.Dendrites.TextbookColor; hd.Dendrites.TextbookColor; hd.SectorPlates.TextbookColor],4,[],3));
        intermediateSPD_floor.EdgeColor = 'none';
        intermediateSPD_wall = patch([hd.SectorPlates.vaporExcBounds(2,3) hd.SectorPlates.vaporExcBounds(2,2) hd.Dendrites.vaporExcBounds(1) hd.Dendrites.vaporExcBounds(4)], [hd.SectorPlates.TempBounds(3) hd.SectorPlates.TempBounds(2) hd.Dendrites.TempBounds(1) hd.Dendrites.TempBounds(3)],reshape([hd.SectorPlates.TextbookColor; hd.SectorPlates.TextbookColor; hd.Dendrites.TextbookColor; hd.Dendrites.TextbookColor],4,[],3));
        intermediateSPD_wall.EdgeColor = 'none';
        intermediateSPD_ceiling = patch([hd.Dendrites.vaporExcBounds(4),hd.Dendrites.vaporExcBounds(4) hd.SectorPlates.vaporExcBounds(6) hd.SectorPlates.vaporExcBounds(9)], [hd.Dendrites.TempBounds(4) hd.SectorPlates.TempBounds(11) hd.SectorPlates.TempBounds(11),hd.Dendrites.TempBounds(4)],reshape([hd.Dendrites.TextbookColor; hd.SectorPlates.TextbookColor; hd.SectorPlates.TextbookColor; hd.Dendrites.TextbookColor],4,[],3));
        intermediateSPD_ceiling.EdgeColor = 'none';
        intermediateSPD_triangleTop = patch([hd.SectorPlates.vaporExcBounds(2,3) hd.Dendrites.vaporExcBounds(4) hd.Dendrites.vaporExcBounds(1)], [hd.SectorPlates.TempBounds(3) hd.Dendrites.TempBounds(3) hd.SectorPlates.TempBounds(3)], reshape([hd.SectorPlates.TextbookColor; hd.Dendrites.TextbookColor; hd.SectorPlates.TextbookColor],3,[],3));
        intermediateSPD_triangleTop.EdgeColor = 'none';
        intermediateSPD_triangleBottom = patch([hd.SectorPlates.vaporExcBounds(2,2), hd.Dendrites.vaporExcBounds(1), hd.Dendrites.vaporExcBounds(1)], [hd.SectorPlates.TempBounds(2), hd.Dendrites.TempBounds(1), hd.SectorPlates.TempBounds(2)],reshape([hd.SectorPlates.TextbookColor; hd.Dendrites.TextbookColor; hd.SectorPlates.TextbookColor],3,[],3));
        intermediateSPD_triangleBottom.EdgeColor = 'none';
        
        mixed1 = patch(hd.Mixed.vaporExcBounds(1,:),hd.Mixed.TempBounds(1,:),hd.Mixed.TextbookColor);
        mixed1.EdgeColor = 'none';
        
        mixed2 = patch(hd.Mixed.vaporExcBounds(2,:),hd.Mixed.TempBounds(2,:),hd.Mixed.TextbookColor);
        mixed2.EdgeColor = 'none';
        warmerThanFreezing = patch(hd.warm.vaporExcBounds(1,:),hd.warm.TempBounds(1,:),hd.warm.Color);
        warmerThanFreezing.EdgeColor = 'none';
        subsaturated = patch(hd.subsaturated.vaporExcBounds,hd.subsaturated.TempBounds,hd.subsaturated.Color);
        subsaturated.EdgeColor = 'none';
        %unnaturalVent = patch(hd.unnaturalVent.vaporExcBounds,hd.unnaturalVent.TempBounds,hd.unnaturalVent.Color);
        %unnaturalVent.EdgeColor = 'none';
        unnatural105 = patch(hd.unnatural105.vaporExcBounds,hd.unnatural105.TempBounds,hd.unnatural105.Color);
        unnatural105.EdgeColor = 'none';
        hold on
        
        % Plot other lines
        Tupper = 15; Tlower = -70;
        TlineStandardC = Tupper:-0.1:Tlower;
        for rhwc = [90:-10:0, 100, 102.5, 105]
            actHandle = num2str(rhwc);
            actHandleNoPunct = actHandle(actHandle~='.');
            eswLine_Handles.(['p', actHandleNoPunct, 'Num']) = eswLine(rhwc,Tlower,Tupper);
            eswLine_Handles.(['p', actHandleNoPunct, 'Vde']) = iceSupersatToVaporExc(eswLine_Handles.(['p', actHandleNoPunct, 'Num']),TlineStandardC);
            if rhwc>100
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot']) = plot(eswLine_Handles.(['p', actHandleNoPunct, 'Vde']),TlineStandardC);
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot']).LineStyle = '-.';
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot']).LineWidth = 0.5;
            elseif rhwc == 100
%                 eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']) = plot(eswLine_Handles.(['p', actHandleNoPunct, 'Num'])(1:526),TlineStandardC(1:526));
%                 eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']) = plot(eswLine_Handles.(['p', actHandleNoPunct, 'Num'])(564:end),TlineStandardC(564:end));
%                 eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']).LineStyle = '-'; eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']).LineStyle = '-';
%                 eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']).LineWidth = 2.5; eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']).LineWidth = 2.5;
%                 eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']).Color = [144 143 143]./255; eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']).Color = [144 143 143]./255;
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']) = plot(eswLine_Handles.(['p', actHandleNoPunct, 'Vde'])(1:346),TlineStandardC(1:346));
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']) = plot(eswLine_Handles.(['p', actHandleNoPunct, 'Vde'])(360:end),TlineStandardC(360:end));                
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']).LineStyle = '-'; eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']).LineStyle = '-';
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']).LineWidth = 2.5; eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']).LineWidth = 2.5;
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot1']).Color = [144 143 143]./255; eswLine_Handles.(['p', actHandleNoPunct, 'Plot2']).Color = [144 143 143]./255;
            else
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot']) = plot(eswLine_Handles.(['p', actHandleNoPunct, 'Vde']),TlineStandardC);
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot']).LineStyle = ':';
                eswLine_Handles.(['p', actHandleNoPunct, 'Plot']).LineWidth = 1.5;
            end
            eswLine_Handles.(['p', actHandleNoPunct, 'Plot']).Color = [144 143 143]./255;
        end
        
        %Approximate maximum supersaturation with ventilation line
        %maxVentLine = plot(2.*eswLineDataVde(151:end),TlineStandardC(151:end));
        %maxVentLine.Color = [0 26 255]./255;
        %maxVentLine.LineWidth = 1.2;
        
        % On-figure isohume labels
        l70Vde = text(0.00524,-44.2,'70%');
        l70Vde.FontName = 'Lato'; l70Vde.FontSize = 16;
        l70Vde.Rotation = -85.8;
        l80Vde = text(0.02493,-36.7,'80%');
        l80Vde.FontName = 'Lato'; l80Vde.FontSize = 16;
        l80Vde.Rotation = -80;
        l90Vde = text(0.06927,-30.6,'90%');
        l90Vde.FontName = 'Lato'; l90Vde.FontSize = 16;
        l90Vde.Rotation = -50;
        l100Vde = text(0.1866,-21,'100%');
        l100Vde.FontName = 'Lato'; l100Vde.FontSize = 16;
        l100Vde.Rotation = -27;
        l2p5Vde = text(0.2133,-20.8,'102.5%');
        l2p5Vde.FontName = 'Lato'; l2p5Vde.FontSize = 16;
        l2p5Vde.Rotation = -22;
        l5Vde = text(0.2245,-22,'105% ');
        l5Vde.FontName = 'Lato'; l5Vde.FontSize = 16;
        l5Vde.Rotation = -18;
        l5VdeNote = text(0.238,-20.85,'(approx. max ambient supersat)');
        l5VdeNote.FontName = 'Lato'; l5VdeNote.FontSize = 14;
        l5VdeNote.Rotation = -18.3;
        %lVentVde = text(0.28,-2.9,'Approx. max natural supersat (with ventilation)');
        %lVentVde.FontName = 'Lato'; lVentVde.FontSize = 12;
        %lVentVde.Rotation = 7;
        
        % On-figure growth mode labels
        lEdgeWarmVde = text(0.01,-2,'Edge (plate-like)');
        lEdgeWarmVde.FontName = 'Lato'; lEdgeWarmVde.FontSize = 16;
        lFaceVde = text(0.07,-6,'Face (column-like)');
        lFaceVde.FontName = 'Lato'; lFaceVde.FontSize = 16;
        lEdgeColdVde = text(0.12,-14,'Edge (plate-like)');
        lEdgeColdVde.FontName = 'Lato'; lEdgeColdVde.FontSize = 16;
        lCornerSectorVde = text(0.227,-10,'Corner ');
        lCornerSectorVde.FontName = 'Lato'; lCornerSectorVde.FontSize = 16;
        lCornerSectorVdeSubtype = text(0.2438,-10,'(sector)');
        lCornerSectorVdeSubtype.FontName = 'Lato'; lCornerSectorVdeSubtype.FontSize = 14;
        lCornerBranchedVde = text(0.255,-15.5,'Corner');
        lCornerBranchedVde.FontName = 'Lato'; lCornerBranchedVde.FontSize = 16;
        lCornerBranchedVde2 = text(0.265,-14.42,'(branched)');
        lCornerBranchedVde2.FontName = 'Lato'; lCornerBranchedVde2.FontSize = 14;
        lPolycrystalsPlatelikeVde = text(0.085,-26,'Platelike polycrystalline');
        lPolycrystalsPlatelikeVde.FontName = 'Lato'; lPolycrystalsPlatelikeVde.FontSize = 16;
        lPolycrystalsColumnarVde = text(0.004,-48.05,{'Columnar', 'polycrystalline'});
        lPolycrystalsColumnarVde.FontName = 'Lato'; lPolycrystalsColumnarVde.FontSize = 16;
        lMixedVde = text(0.004,-16,{'Mixed (polycrystalline,', 'edge, face, and equiaxed)'});
        lMixedVde.FontName = 'Lato'; lMixedVde.FontSize = 16;
        
        % Diagram settings
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
        xLab = xlabel('Vapor density excess (gm^{-3})');
        xLab.FontName = 'Lato Bold';
        axe.YTick = [-70 -60 -55 -50 -40 -30 -22 -20 -18 -16 -14 -12 -10 -8 -6 -4 -2 0 2 4 6 8 10 12];
        axe.Layer = 'top'; %Forces tick marks to be displayed over the patch objects
        axe.YDir = 'reverse';
    otherwise
        close all
        inputFailureMsg = 'Invalid input! Please check input and try again.';
        error(inputFailureMsg)
end

%% Prompt user whether to save figure as PNG
% saveFigPrompt = 'Save figure as PNG? [Y/N] ';
% saveYesNo = input(saveFigPrompt,'s');
% 
% set(gcf, 'PaperUnits','points','PaperPosition', [1 1 1440 849]);
% set(gcf,'renderer','Painters')
% 
% if strcmp(saveYesNo,'Y') || strcmp(saveYesNo,'y')
%     saveFilename = ['igd_' char(castInTermsOf)];
%     disp(['Saving figure as: ' saveFilename '.png'])
%     saveas(gcf,saveFilename,'png');
% end

end
