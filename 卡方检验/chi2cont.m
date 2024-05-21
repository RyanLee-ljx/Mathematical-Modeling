function [h,p,X2] = chi2cont(x,alpha)
%CHI2CONT performs a chi-square test for an m-by-n contingency table
%
%   H = CHI2CONT(X) performs a chi-square test on the data in the m-by-n
%   contingency table X. The null hypothesis is that there is no difference
%   in the row variable distribution ('outcomes') between the columns
%   ('treatments'). The result of the test is returned in H. H=1 indicates a
%   rejection of the null hypothesis at the 5% significance level. H=0
%   indicates that the null hypothesis cannot be rejected at the 5%
%   significance level.
%
%   H = CHI2CONT(X,ALPHA) performs the test at the (100*ALPHA)% significance
%   level. The default when unspecified is ALPHA=0.05;
%
%   [H,P] = CHI2CONT(...) returns the p-value of the test. The p-value is
%   the probability, under the null hypothesis, of observing a value as
%   extreme or more extreme of the chi-square test statistic.
%
%   [H,P,X2] = CHI2CONT(...) returns the chi-square test statistic.
%
%   Example:
%
%       % A study was conducted to determine whether there was a difference
%       % in response to various treatments in patients with rheumatoid
%       % arthritis. The data are shown below:
%
%       x = [18 6 6; 6 9 9; 9 18 12; 3 3 9];
%
%       % Perform a chi-square test on this data:
%
%       [h,p,X2] = chi2cont(x)
%
%       % The result indicates that there is a significant difference in
%       % response to treatment at the 5% significance level (h=1). The p-value
%       % is very small (p=0.0004), indicating strong evidence against the null
%       % hypothesis. The chi-square test statistic is X2=22.15.
%
%   See also CHI2GOF, CHI2INV, CHI2PDF, CHI2RND, CHI2STAT.

if nargin < 1 || isempty(x)
    error('chi2cont:NoData','No data input.')
end

if ~ismatrix(x) || ~isnumeric(x) || any(x(:)<0)
    error('chi2cont:BadData','Data must be a non-negative numeric matrix.')
end

if nargin < 2 || isempty(alpha)
    alpha = 0.05;
end

if ~isscalar(alpha) || ~isnumeric(alpha) || alpha <= 0 || alpha >= 1
    error('chi2cont:BadAlpha','Alpha must be a numeric scalar between 0 and 1.')
end

[m,n] = size(x);
rsum = sum(x,2); % row sums
csum = sum(x,1); % column sums
nobs = sum(rsum); % number of observations

expected = rsum*csum/nobs; % expected frequencies under null hypothesis

X2 = sum(sum((x-expected).^2./expected)); % chi-square test statistic

df = (m-1)*(n-1); % degrees of freedom

p = 1 - chi2cdf(X2,df); % p-value

h = p < alpha; % test result
