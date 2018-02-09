function [ sbenefitsumPAB,AbenefitsumPAB,BbenefitsumPAB,...
    CbenefitsumPAB ] = saleBenefitPAB...
        (ps1,deltavs1,ps2,deltavs2,ps3,deltavs3,...
        pA1,deltavA1,pA2,deltavA2,pA3,deltavA3,...
        pB1,deltavB1,pB2,deltavB2,pB3,deltavB3,...
        pC1,deltavC1,pC2,deltavC2,pC3,deltavC3,...
        dealpowerUC, saledatafunc,...
        gendatafunc, saleprice,genprice,saleintersection,...
        genintersection,salequotationcurvetmp,salevolsum,...
        salevolcurve,genvolsum,nsale,msale,kindex,s,A,B,C)

[uniclearpricePAB,powersumPAB] = clearPricePAB(dealpowerUC,...
    saledatafunc,gendatafunc,true);
[~,nuniclearpricePAB] = size(uniclearpricePAB);

%收益初始化
sbenefitsumPAB = 0;
AbenefitsumPAB = 0;
BbenefitsumPAB = 0;
CbenefitsumPAB = 0;
%高低匹配出清的收益相当于多组边际统一出清
for i = 1:nuniclearpricePAB
    if i == 1
        [ ~,dealpowerUC ] = clearPriceUC( saleprice,salevolsum,...
            saleintersection,genprice,genvolsum,genintersection,...
            powersumPAB(i+1),kindex,false,false);
        
         %更新市场实际需求电量与售电侧的交点坐标
        nsaleintersection = saledatafunc(dealpowerUC);
        
        [ sbenefitPABtmp,AbenefitPABtmp,BbenefitPABtmp,...
            CbenefitPABtmp ] = saleBenefitUC...
        (ps1,deltavs1,ps2,deltavs2,ps3,deltavs3,...
        pA1,deltavA1,pA2,deltavA2,pA3,deltavA3,...
        pB1,deltavB1,pB2,deltavB2,pB3,deltavB3,...
        pC1,deltavC1,pC2,deltavC2,pC3,deltavC3,...
        saleprice,genprice,saleintersection,nsaleintersection,genintersection,...
        uniclearpricePAB(i),powersumPAB(i+1),dealpowerUC ,salequotationcurvetmp,...
        salevolsum,salevolcurve,genvolsum,nsale,msale,s,A,B,C,false,false);

        sbenefitsumPAB = sbenefitsumPAB+sbenefitPABtmp;
        AbenefitsumPAB = AbenefitsumPAB +  AbenefitPABtmp;
        BbenefitsumPAB = BbenefitsumPAB +  BbenefitPABtmp;
        CbenefitsumPAB = CbenefitsumPAB +  CbenefitPABtmp;
    else
        
         [ ~,dealpowerUC ] = clearPriceUC( saleprice,salevolsum,...
            saleintersection,genprice,genvolsum,genintersection,...
            powersumPAB(i+1),kindex,false,false);
        
        %更新市场实际需求电量与售电侧的交点坐标
        nsaleintersection = saledatafunc(dealpowerUC);
        
        [ sbenefitPABtmp1,AbenefitPABtmp1,BbenefitPABtmp1,...
            CbenefitPABtmp1 ] = saleBenefitUC...
        (ps1,deltavs1,ps2,deltavs2,ps3,deltavs3,...
        pA1,deltavA1,pA2,deltavA2,pA3,deltavA3,...
        pB1,deltavB1,pB2,deltavB2,pB3,deltavB3,...
        pC1,deltavC1,pC2,deltavC2,pC3,...
    deltavC3,saleprice,genprice,saleintersection,...
    nsaleintersection,genintersection,...
        uniclearpricePAB(i),powersumPAB(i+1),dealpowerUC,salequotationcurvetmp,...
        salevolsum,salevolcurve,genvolsum,nsale,msale,s,A,B,C,false,false);
    
        [ ~,dealpowerUC ] = clearPriceUC( saleprice,salevolsum,...
        saleintersection,genprice,genvolsum,genintersection,...
        powersumPAB(i),kindex,false,false);
        
        %更新市场实际需求电量与售电侧的交点坐标
        nsaleintersection = saledatafunc(dealpowerUC);
    
         [ sbenefitPABtmp2,AbenefitPABtmp2,BbenefitPABtmp2,...
            CbenefitPABtmp2 ] =saleBenefitUC(ps1,deltavs1,ps2,deltavs2,ps3,deltavs3,...
            pA1,deltavA1,pA2,deltavA2,pA3,deltavA3,...
            pB1,deltavB1,pB2,deltavB2,pB3,deltavB3,...
            pC1,deltavC1,pC2,deltavC2,pC3,deltavC3,...
            saleprice,genprice,saleintersection,nsaleintersection,...
         genintersection,uniclearpricePAB(i),powersumPAB(i),dealpowerUC,...
         salequotationcurvetmp,salevolsum,salevolcurve,genvolsum,...
         nsale,msale,s,A,B,C,false,false);
        
        sbenefitsumPAB = sbenefitsumPAB +sbenefitPABtmp1-sbenefitPABtmp2;
        AbenefitsumPAB = AbenefitsumPAB +AbenefitPABtmp1-AbenefitPABtmp2;
        BbenefitsumPAB = BbenefitsumPAB + BbenefitPABtmp1-BbenefitPABtmp2;
        CbenefitsumPAB = CbenefitsumPAB + CbenefitPABtmp1-CbenefitPABtmp2;
    end
end
    disp(strcat('高低匹配出清方式下，售电公司s的收益: ', num2str(sbenefitsumPAB),'$'));
    disp(strcat('高低匹配出清方式下，售电公司A的收益: ', num2str(AbenefitsumPAB),'$'));
    disp(strcat('高低匹配出清方式下，售电公司B的收益: ', num2str(BbenefitsumPAB),'$'));
    disp(strcat('高低匹配出清方式下，售电公司C的收益: ', num2str(CbenefitsumPAB),'$'));
    disp('*********************************************************');
end


