// int main(){
//     int tab[]={1,2,3,7,15,0x23};
//     int i=0;
//     while (i<6 && tab[i]!=7) i++;
//     P1.6=(i==6?1:0);
//     while(1);
// }

int P1_6 = 0;

int main(){
    int tab[]={1,2,3,7,15,0x23};
    int i=0;

    while (i<6) {
        if (tab[i] != 7) {
            i++;
        } else {
            break;
        }
    }

    if (i==6) {
        P1_6 = 1;
    } else {
        P1_6 = 0;
    }

    while(1);
}