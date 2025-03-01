#include<stdio.h>
#include<limits.h>
#define MAX 10
#define inf INT_MAX

void AllPaths(int cost[MAX][MAX],int A[MAX][MAX],int n){
    int i,j,k;

    printf("A 0 = \t\t\t\t P 0 =\n");
    for(i=0;i<n;i++){
        printf("    ");
        for(j=0;j<n;j++){
            A[i][j]=cost[i][j];
            
            if(A[i][j] == inf)
                printf("%4s ", "inf");
            else
                printf("%4d ", A[i][j]);
        }
        printf("\n");
    }
    printf("\n");
    
    for(k=0;k<n;k++){
        printf("A %d = \t\t\t\t P %d =\n",k+1,k+1);
        for(i=0;i<n;i++){
            printf("    ");
            for(j=0;j<n;j++){
                if(A[i][k] != inf && A[k][j] != inf && A[i][j]>A[i][k]+A[k][j]){
                    A[i][j]=A[i][k]+A[k][j];
                }
                if(A[i][j] == inf)
                    printf("%4s ", "inf");
                else
                    printf("%4d ", A[i][j]);
            }
            printf("\n");
        }
        printf("\n\n");
    }
}

void BellmanFord(int v,int costy[][MAX],int dist[],int no){
    int i,k,u;

    for(i=0;i<no;i++){
        dist[i]=costy[v][i];
    }
    printf("  u / i  | 1 | 2 | 3 | 4 | 5 | 6 | 7 |\n");
    printf("dist [1] |");
    for(i=0;i<no;i++){        
        if(dist[i] == inf)
            printf("%3s|", "inf");
        else
            printf("%2d |",dist[i]);
    }
    printf("\n");

    for(k=1;k<no-1;k++){
        printf("dist [%d] |",k+1);
        for(u=0;u<no;u++){
            if(u!=v && costy[v][u]!=inf){
                //printf("dist %d [%d] |",k,u);
                for(i=0;i<no;i++){
                    if(costy[i][u] != inf && dist[i] != inf && dist[u]>dist[i]+costy[i][u]){
                        dist[u]=dist[i]+costy[i][u];
                    }
                }
                
                if(dist[u] == inf)
                    printf("%3s|", "inf");
                else
                    printf("%2d |",dist[u]);
            }
        }
        printf("\n");
    }
    printf("\n\n");
}

int main(){
    /*int n;
    printf("Enter the number of vertices: ");
    scanf("%d",&n);
    
    int cost[n][n],A[n][n];
    printf("Enter the cost matrix:\n");
    for(int i=0;i<n;i++){
        for(int j=0;j<n;j++){
            cost[i][j]=inf;
            A[i][j]=inf;
            if(i==j){                
                cost[i][j]=0;
                A[i][j]=0;
            }
            scanf("%d",&cost[i][j]);
            if(cost[i][j]==0 && i!=j){
                cost[i][j]=inf;
            }
        }
    }*/

    int n=5;
    int cost[MAX][MAX],A[MAX][MAX];

    for(int i=0;i<n;i++){
        for(int j=0;j<n;j++){
            cost[i][j]=inf;
            A[i][j]=inf;
            if(i==j){                
                cost[i][j]=0;
                A[i][j]=0;
            }
        }
    }
    cost[0][1] = 8;
    cost[0][2] = 3;
    cost[0][4] = -4;
    cost[1][0] = 2;
    cost[1][2] = -2;
    cost[1][3] = 4;
    cost[1][4] = 7;
    cost[2][1] = 2;
    cost[2][3] = 6;
    cost[3][0] = -2;
    cost[3][2] = -5;
    cost[3][4] = -2;
    cost[4][0] = 6;
    cost[4][3] = 6;

    AllPaths(cost,A,n);

    /*int v,no;
    printf("Enter the number of vertices: ");
    scanf("%d",&no);

    int costy[no][no],dist[no];
    printf("Enter the cost matrix:\n");
    for(int i=0;i<no;i++){
        dist[i]=inf;
        for(int j=0;j<no;j++){
            if(i==j){                
            costy[i][j]=0;
        }
            costy[i][j]=inf;
            scanf("%d",&costy[i][j]);
            if(costy[i][j]==0 && i!=j){
                costy[i][j]=inf;
            }
        }
    }
    printf("Enter the starting (source) vertex: ");
    scanf("%d",&v);*/

    int v=0,no=7;
    int costy[MAX][MAX],dist[MAX];
    for(int i=0;i<no;i++){
        dist[i]=inf;
        for(int j=0;j<no;j++){
            costy[i][j]=inf;
            if(i==j){                
                costy[i][j]=0;
                dist[i]=0;
            }
        }
    }
    costy[0][1] = 6;
    costy[0][2] = 5;
    costy[0][3] = 5;
    costy[1][2] = 3;
    costy[1][4] = -1;
    costy[1][5] = 2;
    costy[1][6] = 3;
    costy[2][0] = 16;
    costy[2][1] = -2;
    costy[2][4] = 1;
    costy[3][0] = -2;
    costy[3][1] = 3;
    costy[3][2] = -2;
    costy[3][5] = -1;
    costy[4][0] = 1;
    costy[4][1] = 2;
    costy[4][5] = 5;
    costy[4][6] = 3;
    costy[5][0] = 4;
    costy[5][1] = 1;
    costy[5][6] = 3;
    costy[6][0] = -2;
    costy[6][1] = -1;
    costy[6][2] = 3;
    costy[6][5] = -2;

    BellmanFord(v,costy,dist,no);

    return 0;
}
