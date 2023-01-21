int P1_6 = 0;

int zoek(const int *tab, int n, int getal){
    int i=0;
    while(i<n) {
        if (tab[i]!=getal) {
            i++;
        } else {
            break;
        }
    };

    if (i==n) return 0;
    else return 1;
}

int main(){
    int tab[]={1,2,3,7,15,0x23};
    if (zoek(tab,6,7)==1)
        P1_6=0; //aan dus
    else
        P1_6=1; //uit dus
    while(1);
}