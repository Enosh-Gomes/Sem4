#include<stdio.h>
#define MAX 20
int x[MAX],w[MAX],m,n;

void SumOfSub(int s,int k,int r)
{
    //Genereate left child
    x[k]=1;
    if(s+w[k]==m)
    {
        printf("Solution vector x=[ ");
        for(int i=1;i<=n;i++)
        {
            printf("%d ",x[i]);
        }
        printf("]\n");
    }
    else if(s+w[k]+w[k+1]<=m)
    {
        SumOfSub(s+w[k],k+1,r-w[k]);
    }
    //Generate right child
    if((s+r-w[k]>=m) && (s+w[k+1]<=m))
    {
        x[k]=0;
        SumOfSub(s,k+1,r-w[k]);
    }
}

int main()
{
    int i,s=0,k=1,r=0;
    printf("Enter the number of numbers: ");
    scanf("%d",&n);
    for(i=1;i<=n;i++)
    {
        x[i]=0;
    }
    printf("Enter the numbers: ");
    for(i=1;i<=n;i++)
    {
        scanf("%d",&w[i]);
        r+=w[i];
    }
    printf("Enter the target sum: ");
    scanf("%d",&m);

    SumOfSub(s,k,r);

    /*
    case 1:
    n=7, m=28, w[]={1,2,3,7,18,23,28}; //4 solutions
    
    case 2:
    n=7, m=28, w[]={28,23,18,7,3,2,1,};  //3 solutions
    
    case 3:
    n=7, m=28, w[]={23,7,3,1,28,2,18};  //1 solution

    height of tree to be displayed
    */

    return 0;
}