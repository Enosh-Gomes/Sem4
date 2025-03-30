#include<stdio.h>
#include<stdlib.h>
#include<limits.h>
#include<stdbool.h>
#include<time.h>
#include<windows.h>

#define INF INT_MAX
#define MAX 20
int cost[MAX],bcost[MAX];

long long current_time_us(){
    LARGE_INTEGER freq, counter;
    QueryPerformanceFrequency(&freq);
    QueryPerformanceCounter(&counter);
    return (counter.QuadPart * 1000000) / freq.QuadPart;
}

void FGraph(int G[MAX][MAX], int k, int n, int p[MAX]){
    double cost[MAX];
    int d[MAX], stage[MAX];

    cost[n] = 0.0; stage[n] = k;
    printf("cost[%02d,%2d] = %.2f\td[%02d,%2d] = %d\n", stage[n], n, cost[n], stage[n], n, d[n]);

    for(int j=n-1; j>=1; j--){
        double minCost = INT_MAX;
        int r = -1;
        int maxStage = 0;
        for(int v = j+1; v<=n; v++){
            if(G[j][v]!=0){
                if(G[j][v] + cost[v] < minCost){
                    minCost = G[j][v] + cost[v];
                    r = v;
                }
                if(stage[v] > maxStage){
                    maxStage = stage[v];
                }
            }
        }

        cost[j] = minCost;
        d[j] = r;
        stage[j] = maxStage - 1;

        printf("cost[%02d,%2d] = %.2f\td[%02d,%2d] = %d\n", stage[j], j, cost[j], stage[j], j, d[j]);
    }
    p[1] = 1; p[k] = n;
    for(int j = 2; j < k; j++){
        p[j] = d[p[j-1]];
    }
}

void BGraph(int G[MAX][MAX], int k, int n, int p[MAX]){
    double bcost[MAX];
    int d[MAX], stage[MAX];

    bcost[1] = 0.0; stage[1] = 1;
    printf("cost[%02d,%2d] = %.2f\td[%02d,%2d] = %d\n", stage[1], 1, bcost[1], stage[1], 1, d[1]);

    for(int j=2; j<=n; j++){
        double minCost = INT_MAX;
        int r = -1;
        int maxStage = 0;

        for(int v = j-1; v>=1; v--){
            if(G[v][j]!=0){
                if(G[v][j] + bcost[v] < minCost){
                    minCost = G[v][j] + bcost[v];
                    r = v;
                }
                if(stage[v] > maxStage){
                    maxStage = stage[v];
                }
            }
        }

        bcost[j] = minCost;
        d[j] = r;
        stage[j] = maxStage + 1;

        printf("cost[%02d,%2d] = %.2f\td[%02d,%2d] = %d\n", stage[j], j, bcost[j], stage[j], j, d[j]);
    }
    p[1] = 1; p[k] = n;
    for(int j = k-1; j >= 2; j--){
        p[j] = d[p[j+1]];
    }
}

void create(int G[][MAX],int n,int k){
    int i,j,w,max_edges,origin,destin;

    printf("Enter the number of vertices: ");
    scanf("%d",&n);
    max_edges=n*(n-1);

    printf("Enter number of stages:");
    scanf("%d",&k);

    for(i=1;i<=n;i++){
        for(j=1;j<=n;j++){
            G[i][j]=INF;
        }
    }

    for(i=1;i<=max_edges;i++){
        printf("Enter edge %d ((-1,-1) to quit): ",i);
        scanf("%d%d",&origin,&destin);
        if ((origin == -1) && (destin == -1))   break;
        if (origin > n || destin > n || origin < 1 || destin < 1) {
            printf("Invalid edge\n");
            i--;
        } else {
            printf("Enter cost: ");
            scanf("%d", &w);
            G[origin][destin] = w;
        }
    }
}

int main() {
    int choice;
    int p[MAX] = {0};
    int n=14, k=5;
    int c[MAX][MAX] = {INF};
  
    int cost[MAX][MAX] = {0};
    int G[MAX][MAX] = {0};

    long long t;
    struct timespec start, end;
    double time_spent;

    //createGraph(G);
    
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

    for (int i = 0; i < MAX; i++) {
        for (int j = 0; j < MAX; j++) {
            cost[i][j] = INF;
        }
    }
    for (int i = 0; i < 15; i++) {
        for (int j = 0; j < 15; j++) {
            cost[i][j] = c[i][j];
        }
    }
    
    do
    {
        printf("\nMenu\n");
        printf("1. Forward Graph Algorithm\n");
        printf("2. Backward Graph Algorithm\n");
        printf("3. Exit\n");
        printf("Enter your choice: ");
        scanf("%d",&choice);

        if (choice==1)
        {            
            printf("Forward Graph Algorithm:\n");
            t = current_time_us();
            timespec_get(&start, TIME_UTC);            
            FGraph(cost, k, n, p);
            timespec_get(&end, TIME_UTC);
            t = current_time_us() - t;
            //double time_spent = ((end.tv_sec - start.tv_sec) * 1e9 + (end.tv_nsec - start.tv_nsec)) / 1e6; // in microseconds
            time_spent = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9; // in seconds

            printf("\nMinimum cost path: ");
            printf("%d", p[1]);
            for(int i = 2; i <= k; i++){
                printf("->%d", p[i]);
            }

            printf("\n\nTime taken for forward graph: %lldμs or %lf seconds\n", t,time_spent);
        }
        else if(choice==2){
            printf("\nBackward Graph Algorithm:\n");
            t = current_time_us();
            timespec_get(&start, TIME_UTC);
            BGraph(cost, k, n, p);
            timespec_get(&end, TIME_UTC);
            t = current_time_us() - t;
            //double time_spent = ((end.tv_sec - start.tv_sec) * 1e9 + (end.tv_nsec - start.tv_nsec)) / 1e6; // in microseconds
            time_spent = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9; // in seconds

            printf("\nMinimum cost path: ");
            printf("%d", p[1]);
            for(int i = 2; i <= k; i++){
                printf("->%d", p[i]);
            }

            printf("\n\nTime taken for backward graph: %lldμs or %lf seconds\n", t,time_spent);
        }
        else if(choice==3){
            continue;
        }
        else{
            printf("Invalid Input");
        }
    } while (choice!=3);   
    return 0;
}
