#include<stdio.h>
#include<stdlib.h>
#include<limits.h>
#include<stdbool.h>
#include<time.h>
#define INF 999999
#define MAX 20
int cost[MAX],bcost[MAX];

void Fdisplay(int c[][MAX],int p[],int k,int n){
    int i,j;
    for(i=k;i>=1;i--){
        for(j=n;j>=1;j--){
            if(c[i][j]!=INF){
                printf("cost[%d][%d]=%d\n",i,j,cost[j]);
            }
        }
        printf("\n");
    }

    printf("Path: %d",p[1]);
    for(i=2;i<=k;i++){
        printf("-%d",p[i]);
    }
    printf("\nCost=%d\n\n",cost[1]);
}

void Bdisplay(int c[][MAX],int p[],int k,int n){
    int i,j;
    for(i=1;i<=k;i++){
        for(j=1;j<=n;j++){
            if(c[i][j]!=INF){
                printf("bcost[%d][%d]=%d\n",i,j,bcost[j]);
            }
        }
        printf("\n");
    }

    printf("Path: %d",p[1]);
    for(i=2;i<=k;i++){
        printf("-%d",p[i]);
    }
    printf("\nCost=%d\n\n",bcost[n]);
}

void FGraph(int c[MAX][MAX],int k,int n,int p[]){
    int j,r,min,d[MAX] = {0};//,cost[MAX] = {INF};

    cost[n]=0.0;
    float x=(float)k-(1/(k-1));
    int stage=k-1;

    for(j=n-1;j>=1;j--){
        x-=0.25;
        stage=x;
        int min = INF;
        for(r=j;r<=n;r++){
            if(c[j][r]!=0 && min>c[j][r]+cost[r]){
                min=c[j][r]+cost[r];
                d[j]=r;
            }
        }
        cost[j]=min;
        printf("Cost(%02d,%02d)=%02d  ",stage,j,cost[j]);
        printf("r(%02d,%02d)=%02d\n",stage,j,r);
    }
    p[1]=1; p[k]=n;
    for(j=2;j<=k-1;j++){
        p[j]=d[p[j-1]];
    }
    //Fdisplay(c,p,k,n);

    printf("\nShortest Path: %d",p[1]);
    for(int i=2;i<=k;i++){
        printf("->%d",p[i]);
    }
    printf("\nMincost=%d\n\n",cost[1]);
}

void BGraph(int c[MAX][MAX],int k,int n,int p[]){
    int i,j,r,min,d[MAX] = {0};//,bcost[MAX] = {INF}
    
    bcost[1]=0.0;
    float x = 1;
    int stage = 1;

    for(j=2;j<=n;j++){
        x+=0.25;
        stage=x;
        int min = INF;
        for(r=j;r<=n;r++){
            if(c[r][j]!=0 && min>c[r][j]+bcost[r]){
                min=c[r][j]+bcost[r];
                d[j]=r;
            }
        }
        bcost[j]=min;
        printf("Cost(%02d,%02d)=%02d  ",stage,j,bcost[j]);
        printf("r(%02d,%02d)=%02d\n",stage,j,r);
    }
    p[1]=1; p[k]=n;
    for(j=k-1;j>=2;j--){
        p[j]=d[p[j+1]];
    }
    //Bdisplay(c,p,k,n);
    
    printf("\nShortest Path: %d",p[1]);
    for(i=2;i<=k;i++){
        printf("->%d",p[i]);
    }
    printf("\nMincost=%d\n\n",bcost[n]);
}

void create(int c[][MAX],int *n,int *k){
    int i,j,w,max_edges,origin,destin;

    printf("Enter the number of vertices: ");
    scanf("%d",&n);
    max_edges=*n*(*n-1);

    printf("Enter number of stages:");
    scanf("%d",&k);

    for(i=1;i<=*n;i++){
        for(j=1;j<=*n;j++){
            c[i][j]=INF;
        }
    }

    for(i=1;i<=max_edges;i++){
        printf("Enter edge %d ((-1,-1) to quit): ",i);
        scanf("%d%d",&origin,&destin);
        if ((origin == -1) && (destin == -1))   break;
        if (origin > *n || destin > *n || origin < 1 || destin < 1) {
            printf("Invalid edge\n");
            i--;
        } else {
            printf("Enter cost: ");
            scanf("%d", &w);
            c[origin][destin] = w;
        }
    }
}

int main(){
    int n=14, k=5;
    int p[k];// = {0};
    int c[MAX][MAX] = {INF};

    /*for (int i = 0; i < MAX; i++){
        for (int j = 0; j < MAX; j++){
            c[i][j] = INF;
        }
        cost[i] = INF;
        bcost[i] = INF;
    }*/

    //create(c,&n,&k);

    c[1][2] = 9;
    c[1][3] = 8;
    c[1][4] = 6;
    c[1][5] = 7;
    c[2][6] = 10;
    c[2][7] = 11;
    c[2][8] = 12;
    c[3][6] = 15;
    c[3][8] = 14;
    c[3][9] = 13;
    c[4][7] = 10;
    c[4][8] = 11;
    c[4][9] = 12;
    c[5][6] = 8;
    c[5][7] = 9;
    c[5][9] = 10;
    c[6][10] = 5;
    c[6][11] = 6;
    c[6][13] = 7;
    c[7][10] = 8;
    c[7][11] = 9;
    c[7][12] = 7;
    c[8][11] = 6;
    c[8][12] = 7;
    c[8][13] = 8;
    c[9][10] = 5;
    c[9][12] = 8;
    c[9][13] = 6;
    c[10][14] = 8;
    c[11][14] = 9;
    c[12][14] = 8;
    c[13][14] = 7;

    FGraph(c,k,n,p);
    BGraph(c,k,n,p);
    return 0;
}
