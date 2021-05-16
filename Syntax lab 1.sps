* Encoding: UTF-8.

DATASET ACTIVATE DataSet1.
FREQUENCIES VARIABLES=mortalityInfant 
    Womenparticipatinginthethreedecisionsownhealthcaremajorhousehold 
    CurrenthealthexpenditurepercapitaPPPcurrentinternational$SH.XPD Time
  /STATISTICS=STDDEV VARIANCE MINIMUM MAXIMUM MEAN SKEWNESS SESKEW KURTOSIS SEKURT
  /HISTOGRAM NORMAL
  /ORDER=ANALYSIS.

CORRELATIONS
  /VARIABLES=mortalityInfant CurrenthealthexpenditurepercapitaPPPcurrentinternational$SH.XPD 
    Womenparticipatinginthethreedecisionsownhealthcaremajorhousehold Time
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.

REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA COLLIN TOL
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT mortalityInfant
  /METHOD=ENTER Womenparticipatinginthethreedecisionsownhealthcaremajorhousehold 
    CurrenthealthexpenditurepercapitaPPPcurrentinternational$SH.XPD Time
  /SCATTERPLOT=(*ZRESID ,*ZPRED)
  /RESIDUALS DURBIN NORMPROB(ZRESID)
  /SAVE COOK.

* Chart Builder.
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=
    Womenparticipatinginthethreedecisionsownhealthcaremajorhousehold mortalityInfant MISSING=LISTWISE 
    REPORTMISSING=NO
  /GRAPHSPEC SOURCE=INLINE
  /FITLINE TOTAL=YES.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: Womenparticipatinginthethreedecisionsownhealthcaremajorhousehold=col(source(s), 
    name("Womenparticipatinginthethreedecisionsownhealthcaremajorhousehold"))
  DATA: mortalityInfant=col(source(s), name("mortalityInfant"))
  GUIDE: axis(dim(1), label("Women participating in the three decisions (own health care, major ",
    "household purchases, and visiting family) (% of women age 15-49)"))
  GUIDE: axis(dim(2), label("Mortality rate, infant (per 1,000 live births)"))
  GUIDE: text.title(label("Simple Scatter with Fit Line of Mortality rate, infant (per 1,000 ",
    "live births) by Women participating in the three decisions (own health care, major household ",
    "purchases, and visiting family) (% of women age 15-49)"))
  ELEMENT: point(position(Womenparticipatinginthethreedecisionsownhealthcaremajorhousehold*
    mortalityInfant))
END GPL.

* Chart Builder.
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=
    CurrenthealthexpenditurepercapitaPPPcurrentinternational$SH.XPD[name=
    "CurrenthealthexpenditurepercapitaPPPcurrentinternational_SH_XPD"] mortalityInfant Time 
    Womenparticipatinginthethreedecisionsownhealthcaremajorhousehold MISSING=LISTWISE REPORTMISSING=NO
  /GRAPHSPEC SOURCE=INLINE
  /FITLINE TOTAL=NO.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: CurrenthealthexpenditurepercapitaPPPcurrentinternational_SH_XPD=col(source(s), 
    name("CurrenthealthexpenditurepercapitaPPPcurrentinternational_SH_XPD"))
  DATA: mortalityInfant=col(source(s), name("mortalityInfant"))
  DATA: Time=col(source(s), name("Time"))
  DATA: Womenparticipatinginthethreedecisionsownhealthcaremajorhousehold=col(source(s), 
    name("Womenparticipatinginthethreedecisionsownhealthcaremajorhousehold"))
  GUIDE: axis(dim(1.1), ticks(null()))
  GUIDE: axis(dim(2.1), ticks(null()))
  GUIDE: axis(dim(1), gap(0px))
  GUIDE: axis(dim(2), gap(0px))
  GUIDE: text.title(label("Scatterplot Matrix Current health expenditure per capita, PPP ",
    "(current international $) ,Mortality rate, infant (per 1,000 live births),Time..."))
  TRANS: CurrenthealthexpenditurepercapitaPPPcurrentinternational_SH_XPD_label = eval("Current "+
    "health expenditure per capita, PPP (current international $) ")
  TRANS: mortalityInfant_label = eval("Mortality rate, infant (per 1,000 live births)")
  TRANS: Time_label = eval("Time")
  TRANS: Womenparticipatinginthethreedecisionsownhealthcaremajorhousehold_label = eval("Women "+
    "participating in the three decisions (own health care, major household purchases, and "+
    "visiting family) (% of women age 15-49)")
  ELEMENT: 
    point(position((CurrenthealthexpenditurepercapitaPPPcurrentinternational_SH_XPD/Currenthealthexpendi
    turepercapitaPPPcurrentinternational_SH_XPD_label+mortalityInfant/mortalityInfant_label+
    Time/Time_label+
    Womenparticipatinginthethreedecisionsownhealthcaremajorhousehold/Womenparticipatinginthethreedecisio
    nsownhealthcaremajorhousehold_label)*
    (CurrenthealthexpenditurepercapitaPPPcurrentinternational_SH_XPD/CurrenthealthexpenditurepercapitaPP
    Pcurrentinternational_SH_XPD_label+mortalityInfant/mortalityInfant_label+Time/Time_label+
    Womenparticipatinginthethreedecisionsownhealthcaremajorhousehold/Womenparticipatinginthethreedecisio
    nsownhealthcaremajorhousehold_label)))
END GPL. 

UNIANOVA mortalityInfant WITH Womenparticipatinginthethreedecisionsownhealthcaremajorhousehold 
    CurrenthealthexpenditurepercapitaPPPcurrentinternational$SH.XPD Time
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PRINT PARAMETER
  /CRITERIA=ALPHA(.05)  
  /ROBUST=HC3
  /DESIGN=Womenparticipatinginthethreedecisionsownhealthcaremajorhousehold 
    CurrenthealthexpenditurepercapitaPPPcurrentinternational$SH.XPD Time.

REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA COLLIN TOL
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT mortalityInfant
  /METHOD=ENTER Womenparticipatinginthethreedecisionsownhealthcaremajorhousehold
  /METHOD=ENTER CurrenthealthexpenditurepercapitaPPPcurrentinternational$SH.XPD
  /METHOD=ENTER Time
  /SCATTERPLOT=(*ZRESID ,*ZPRED)
  /RESIDUALS DURBIN NORMPROB(ZRESID)
  /SAVE COOK.
