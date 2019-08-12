#=head1 COCOMO Software Cost Estimation

#=head2 Copyright

#This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, version 2.
#This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA. 


#=head2 History

#This is version three of this code. Version one
#was written by Tim Menzies based on the first half of
#chpater two of [L<Boehm00>]. Version two was written by
#Rizal Arryadi
#Ying Shen,
#WaiSee Tang, and
#Margaret Wang who fixed numerous bugs and added some useful
#utilities.
#This version three is Tim's "improvements" on version two.


#=head1 The COCOMO model

#The COCOMO project aims at developing an open-source, public-domain
#software effort estimation model. The project has collected
#information on 161 projects from commercial, aerospace, government,
#and non-profit organizations [L<Chulani99>,L<Boehm00>]. As of 1998, the
#projects represented in the database were of size 20 to 2000 KSLOC
#(thousands of lines of code) and took between 100 to 10000 person
#months to build.

#COCOMO measures effort in calendar months where one month is 152 hours
#(and includes development and management hours). The core intuition
#behind COCOMO-based estimation is that as systems grow in size, the
#effort required to create them grows exponentially, i.e.

# effort = k*KSLOC^x.

#More precisely:

# months=a*KSLOC^(0.91+
#                   SF1+SF2+ .. +SF5
#                ) *
#                EM1 * EM2 * .. * OAEM17

#where a is a domain-specific parameter, and KSLOC is estimated
# directly or computed from a function point analysis. SF.i are the
# scale factors (e.g. factors such as ``have we built this kind of
# system before?'') and EM.j are the effort multipliers (e.g. required
# level of reliability). The scale drivers and effort multipliers and
# shown below.

#=image center URL/cocomo/etc/img/cocomo.jpg

#(Errata: third line; B<aexp> should be B<apex>. 
#Also, line 12, B<pexp> should be B<plex>)

#Before seeing them, we note that software effort-estimation
#     models like COCOMO-II should be tuned to their local
#     domain. Off-the-shelf untuned models have been up to 600%
#     inaccurate in their estimates (e.g. see [L<Mukho92>,p165] or
#     [L<Kemerer87>]. However, tuned models can be far more accurate. For
#     example, [L<Chulani99>] reports a study with a bayesian tuning
#     algorithm using the COCOMO project database. After bayesian
#     tuning, a cross-validation study showed that COCOMO-II model
#     produced estimates that are within 30% of the actuals, 69% of the
#     time.

#Various tunings for COCOMO are shown below. While they are
#domain-specific, some things usually hold across all tunings.
#Software costs I<decrease> as projects:

#=over 8

#=item *

#I<Increase> the scale factors.

#=item *

#I<Increase> the personnel and
#project attributes: acap, pcap, pcob, apex, plex, ltex, tool, site,
#sced.

#=back 

#On the other hand, software costs I<increase> as projects 

#=over 8

#=item *

#I<Increase> the product and platform attributes: rely, data, cplx, ruse, docu, time, stor, pvol. 

#=back

#=head1 The Model

#=head2 estimate

#Computes the number of staff, nominal schedule, 
#and months needed

 function estimate() {
   staff = (months=pm())/(timE=tdev());
   report(months,timE,staff); 
 }

#=head2 size

#Computes the total lines of source code which includes
# the new source code and also equivalent adapted source
# scaled(nonlinearly) to be like "new source code". Here,
# revl() is a factor to model requirements evolution and volatility that
# causes written source code to be abandoned or changed extensively.
# If present (ie nonzero) , will make the total size larger.

 function size() {
   return (1+(revl()/100)) *(newKsloc()+equivalentKsloc());
 }

#=head2 equivalentKsloc

#Computes the "scaled" version of adapted code that
# is an equivalent of new source code (newKsloc).  The converter
# is aam (Adaptation Adjustment Modifier) that models the amount
#of effort in fitting adapted code into existing code.
# at() accounts for automatic translated code and subtracted away
# so that automatic translated code is not counted as effort.

 function equivalentKsloc() {
   return adaptedKsloc()*aam()*(1-(at()/100));
 }

#=head2 aam

#Computes the I<adaptation adjustment modifier> that models the effort in
# fitting adapted code to the system.  It is a function of aaf (
# amount of modification), aa (Assement & Assimilation to determine 
# appropriateness of reused code), su (software understanding) and
# unfm (unfamilarity with the software) 

 function aam(f) {
   f=aaf();
   if (f <=50) {
     return (aa()+f*(1+(0.02*su()*unfm())))/100}
   else return ((aa()+f+(su()*unfm()))/100);
 }

#=head2 aaf

#Computes the amount of modification needed on the adapted code.
# It is a function of dm (design modification effort), cm 
# (code modification effort) and (integration modification effort).

 function aaf() {
   return 0.4*dm()+0.3*cm()+0.3*im();
 }

#=head2 tdev

#Computes the time to develop the software.  It is a function of pmNs
# the nominal person-months required for the project, c, a calibration factor
# for the types of projects, f (a function of scale factors) and scedPercent 
# ( a factor modelling if the schedule is compressed or stretched out).

 function tdev(){
   return (c()*(pmNs()^f()))*scedPercent()/100;
 }

 BEGIN {s2a("vl 75 l 85 n 100 h 130 vh 160",ScedPercents," ")}

 function scedPercent() {return ScedPercents[sced()]}

#=head2 f

#Computes the exponential factor in tdev.  It is a function of e() (the 
# scale factors of a project that have exponential influences).
# d() & b() are calibrated tunings from the cocomo2000 model

 function f() {
   return d()+0.2*(e()-b());
 }

#=head2 pm

#Comutes the personnel-months effort required
# It is a function of pmNs (nominal personnel months) scaled by
# sced (the schedule compression or stretched out factor).
# pmAuto (personnel months associated with automatic translated code)
# is also added.

 function pm() {
   return pmNs()*sced()+pmAuto();
 }

#=head2 pmNs

#Computes the nominal personnel-months effort model
# proposed by cocomo with scale factors in e() and the
# list of effort multipliers.

 function pmNs() { 
	return a()*(size()^e())*   \
 	  rely()*data()*cplx()* ruse()* \
	  docu()* time()*stor()*    \
	  pvol()* acap()* pcap()*   \
	  pcon()*apex()*plex()*     \
	  ltex()*tool()*site(); 
 }

#=head2 e

#Computes the exponential scale factors function.

 function e() {
   return b()+0.01*(prec()+flex()+resl()+team()+pmat());
 }

#=head2 pmAuto

#Computes the effort associated with automatic code.

 function pmAuto() {
   return ((adaptedKsloc()*(at()/100))/atKProd());
 }

#=head2 Calibration Factors

 function a() {if (cocomo()==1983) {return 2.5} else {return  2.94}}
 function b() {if (cocomo()==2000) {return 0.91} else {return 1.01}}
 function c() {if (cocomo()==1983) {return 3.0 } else {return 3.67}}
 function d() {if (cocomo()==2000) {return 0.28} else {return 0.33}}

#=head2 Factors & Multipliers

 BEGIN {if(ScaleEffortFile)
   readtable(ScaleEffortFile,ScaleEffort);
 }

 function readtable(file,a,   i,f,line,n,tab) {
   while ((getline line < file) > 0) {
     n=split(line,f,/,/);
     for(i=1;i<=n;i++) f[i]=trim(f[i]);
     if (match(f[1],/^=/)) {
       tab=rhs(f[1]);
       for(i=1;i<n;i++) label[i]=f[i+1];
     } else {
       for(i=1;i<n;i++) a[tab,f[1],label[i]]=f[i+1]}}
 }

#=head1 References

#=over 8

#=item Boehm00

#I<Software Cost Estimation with Cocomo II> (2000) Barry W.Boehm and
#Ellis Horowitz and Ray Madachy and Donald Reifer and Bradford K. Clark
#and Bert Steece and A. Winsor Brown and Sunita Chulani and Chris Abts,
#Prentice Hall ISBN:0130266922

#=item Chulani99

#I<Bayesian Analysis of Empirical Software Engineering Cost Models> (1999) by S. Chulani and B. Boehm and B. Steece, IEEE Transaction on Software Engineering (July/August), volume 25, number 4 

#=item Kemerer87

#I<An Empirical Validation of Software Cost Estimation Models> (1987, June), by C.F. Kemerer, Communications of the ACM, volume 30, number 5, pages 416-429. 

#=item Mukho92

#I<Examining the Feasibility of a Case-based Reasoning Tool for
#Software Effort Estimation> (1992, June) by T. Mukhopadhyay and
#S.S. Vicinanza and M.J. Prietula, MIS Quarterly, pages 155-171.

#=back
