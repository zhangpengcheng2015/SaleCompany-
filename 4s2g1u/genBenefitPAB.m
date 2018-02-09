function [ gabenefitsumPAB,gbbenefitsumPAB] = ...
    genBenefitPAB( pga1,pga2,pga3,deltavga1,...
    deltavga2,deltavga3, pgb1,pgb2,pgb3,deltavgb1,deltavgb2,...
    deltavgb3,dealpowerUC, saledatafunc,...
    gendatafunc, saleprice,genprice,saleintersection,...
    genintersection,genquotationcurvetmp,salevolsum,...
    genvolcurve,genvolsum,ngen,mgen,kindex,ga,gb)

[uniclearpricePAB,powersumPAB] = clearPricePAB(dealpowerUC,...
    saledatafunc,gendatafunc,false);
[~,nuniclearpricePAB] = size(uniclearpricePAB);

%收益初始化
gabenefitsumPAB = 0;
gbbenefitsumPAB = 0;

%高低匹配出清的收益相当于多组边际统一出清
for i = 1:nuniclearpricePAB
    if i == 1
        [ ~,dealpowerUC ] = clearPriceUC( saleprice,salevolsum,...
            saleintersection,genprice,genvolsum,genintersection,...
            powersumPAB(i+1),kindex,false,false);
        
         %更新市场实际需求电量与售电侧的交点坐标
        ngenintersection = gendatafunc(dealpowerUC);
        
        [ gabenefitPABtmp,gbbenefitPABtmp] = genBenefitUC...
        (pga1,pga2,pga3,deltavga1,...
        deltavga2,deltavga3, pgb1,pgb2,pgb3,deltavgb1,deltavgb2,...
        deltavgb3,genprice,genintersection, ngenintersection,...
    genquotationcurvetmp,uniclearpricePAB(i),...
    powersumPAB(i+1),dealpowerUC,genvolsum,false,false);

        gabenefitsumPAB = gabenefitsumPAB+gabenefitPABtmp;
        gbbenefitsumPAB = gbbenefitsumPAB +  gbbenefitPABtmp;
    else
        
         [ ~,dealpowerUC ] = clearPriceUC( saleprice,salevolsum,...
            saleintersection,genprice,genvolsum,genintersection,...
            powersumPAB(i+1),kindex,false,false);
        
        %更新市场实际需求电量与售电侧的交点坐标
        ngenintersection = gendatafunc(dealpowerUC);
        
        [ gabenefitPABtmp1,gbbenefitPABtmp1] = genBenefitUC...
        (pga1,pga2,pga3,deltavga1,...
        deltavga2,deltavga3, pgb1,pgb2,pgb3,deltavgb1,deltavgb2,...
        deltavgb3,genprice,genintersection, ngenintersection,...
        genquotationcurvetmp,uniclearpricePAB(i),powersumPAB(i+1),...
        dealpowerUC,genvolsum,false,false);

    
        [ ~,dealpowerUC ] = clearPriceUC( saleprice,salevolsum,...
        saleintersection,genprice,genvolsum,genintersection,...
        powersumPAB(i),kindex,false,false);
        
        %更新市场实际需求电量与售电侧的交点坐标
        ngenintersection = gendatafunc(dealpowerUC);
    
         [ gabenefitPABtmp2,gbbenefitPABtmp2] =genBenefitUC...
        (pga1,pga2,pga3,deltavga1,deltavga2,deltavga3, ...
        pgb1,pgb2,pgb3,deltavgb1,deltavgb2,deltavgb3,...
        genprice,genintersection, ngenintersection,...
        genquotationcurvetmp,uniclearpricePAB(i),...
        powersumPAB(i+1),dealpowerUC,genvolsum,false,false);

        
        gabenefitsumPAB = gabenefitsumPAB +gabenefitPABtmp1-gabenefitPABtmp2;
        gbbenefitsumPAB = gbbenefitsumPAB +gbbenefitPABtmp1-gbbenefitPABtmp2;
       
    end
end
    disp(strcat('高低匹配出清方式下，发电商ga的收益: ', num2str(gabenefitsumPAB),'$'));
    disp(strcat('高低匹配出清方式下，发电商gb的收益: ', num2str(gbbenefitsumPAB),'$')); 
    disp('*********************************************************');
end


