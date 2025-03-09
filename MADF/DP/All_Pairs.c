#include<stdio.h>
#define MAX 20
#define inf 999999

void printPaths(int P[MAX][MAX], int i, int j) {
    if (i == j) {
        printf("%d", i);
        return;
    }
    printPaths(P, i, P[i][j]); 
    printf("->%d", j);
}

void AllPaths(int cost[MAX][MAX], int A[MAX][MAX], int n) {
    int i, j, k;
    int P[MAX][MAX];

    printf("A 0 =  \t\t\t\t  P 0 =\n");
    for (i = 1; i <= n; i++) {
        printf("    ");
        for (j = 1; j <= n; j++) {
            A[i][j] = cost[i][j];

            if (A[i][j] == inf)
                printf("%4s ", "inf");
            else
                printf("%4d ", A[i][j]);

            P[i][j] = (i == j) ? 0 : i;
        }

        printf("         ");
        for (j = 1; j <= n; j++) {
            printf("%4d ", P[i][j]);
        }

        printf("\n");
    }
    printf("\n");

    for (k = 1; k <= n; k++) {
        printf("A %d = \t\t\t\t P %d =\n", k, k);
        for (i = 1; i <= n; i++) {
            printf("    ");
            for (j = 1; j <= n; j++) {
                if (A[i][k] != inf && A[k][j] != inf && A[i][j] > A[i][k] + A[k][j]) {
                    A[i][j] = A[i][k] + A[k][j];
                    P[i][j] = P[k][j]; 
                }
                if (A[i][j] == inf)
                    printf("%4s ", "inf");
                else
                    printf("%4d ", A[i][j]);
            }

            printf("         ");
            for (j = 1; j <= n; j++) {
                printf("%4d ", P[i][j]);
            }

            printf("\n");
        }
        printf("\n\n");
    }

    printf("Source Destin Length Path\n");
    for (i = 1; i <= n; i++) {
        for (j = 1; j <= n; j++) {
            if (i != j) {
                printf("  %2d     %2d     %2d     ", i, j, A[i][j]);
                printPaths(P, i, j);
                printf("\n");
            }
        }
    }
}

int main(){
    int i, j, n;
    /*printf("Enter the number of vertices: ");
    scanf("%d",&n);
    //n++;

    
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

    n=5;
    int A[MAX][MAX];
    int cost[MAX][MAX];

    for(i=1;i<=n;i++){
        for(j=1;j<=n;j++){
            cost[i][j] = (i == j) ? 0 : inf;
            /*cost[i][j]=inf;
            if(i==j){
                cost[i][j]=0;
            }*/
        }
    }

                
    cost[1][2] = 8;
    cost[1][3] = 3;
    cost[1][5] = -4;
    cost[2][1] = 2;
    cost[2][3] = -2;
    cost[2][4] = 4;
    cost[2][5] = 7;
    cost[3][2] = 2;
    cost[3][4] = 6;
    cost[4][1] = -2;
    cost[4][3] = -5;
    cost[4][5] = -2;
    cost[5][1] = 6;
    cost[5][4] = 6;

    AllPaths(cost,A,n);

    return 0;
}