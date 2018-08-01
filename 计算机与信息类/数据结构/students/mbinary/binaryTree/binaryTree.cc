#include<sstream>
#include<iostream>
#include<vector>
#include<string>
using namespace std;
bool isIn(char c,string s=string(" \n\t"))
{
    for(int i = 0;i<s.size();++i)
        if(c==s[i])return true;
    return false;
}
template<typename type>
class node
{
public:
    type val;
    node *left,*right;
    double wL,wR;
    node(type v=0,node<type>*l=NULL,node<type>*r=NULL,double wl = 0,double wr=0)
        :val(v),left(l),right(r),wL(wl),wR(wr){}
    node(const node<type>& n){*this = n;}
};
template<typename type>
class binaryTree
{
public:
    int leaves;
    int num;
    int height;
    bool weighted ;
    node<type> *root;
    void level_visit();
    int getData(istringstream& ss,node<type>*);
    binaryTree(const string& s=string("0##"),bool wt=false);
    binaryTree(const binaryTree &);
    ~binaryTree(){freeMem(root);}
    node<type>* operator=(const binaryTree & );
    void display();
    void preOrderTraverse(void (*f)(type,double),node<type>*,double=0);
    void inOrderTraverse(void (*f)(type,double),node<type>*,double=0);
    void postOrderTraverse(void (*f)(type,double),node<type>*,double=0);
    node<type>*parent(type val);
    node<type>*self(type val);
    void swap();
    node<type>* delChild(type x);
    node<type>* insertChild(type,node<type> *,char );
private:
    void l_r(node<type> *);
    void freeMem(node<type>*);
    node<type>* cp(node<type>*);
};
template<typename type>
binaryTree<type>::binaryTree(const binaryTree & t)
    :leaves(t.leaves),num (t.num),height(t.height),weighted (t.weighted)
{
    root = cp(t.root);
}
template<typename type>
node<type>* binaryTree<type>::operator=(const binaryTree & t)
{
    if(this = &t) return root;
    leaves = t.leaves;
    num = t.num;
    height = t.height;
    root= cp(t.root);
    return root;
}
template<typename type>
binaryTree<type>::binaryTree(const string &s,bool wt):weighted(wt),num(0),leaves(0)
{
    root = new node<type>;
    istringstream is(s);
    height = getData(is,root);
}
template<typename type>
node<type>* binaryTree<type>::cp(node<type>*you)
{
    if(you==NULL){
        return NULL;
    }
    return new node<type>(you->val,cp(you->left),cp(you->right),you->wL,you->wR);
}
template<typename type>
int binaryTree<type>::getData(istringstream& iss,node<type>*root)
{
     while(isIn(iss.peek()))iss.ignore(1);
     iss>>root->val;
     ++num;
     if(iss.fail()){
        cout<<"Input Error. Initialization Failed!"<<endl;
        return -1;
     }
     bool noLeftChild=false;
     int lh,rh;
     if('#'==iss.peek()){
        iss.ignore(1);
        noLeftChild = true;
        root->left = NULL;
        lh=1;
     }
     else{
        if(weighted){
            iss>>root->wL;
        }
        root->left = new node<type>;
        lh=getData(iss,root->left)+1;
     }
     if('#'==iss.peek()){
        iss.ignore(1);
        if(noLeftChild)leaves +=1;
        root->right = NULL;
        rh=1;
     }
     else{
        if(weighted){
            iss>>root->wR;
        }
        root->right = new node<type>;
        rh=getData(iss,root->right)+1;
     }
     return lh>rh?lh:rh;
}
template<typename type>
void binaryTree<type>::preOrderTraverse(void (*f)(type,double),node<type>*root,double wt)
{
    f(root->val,wt);
    if(root->left!=NULL)preOrderTraverse(f,root->left);
    if(root->right!=NULL)preOrderTraverse(f,root->right);
}
template<typename type>
void binaryTree<type>::postOrderTraverse(void (*f)(type,double),node<type>*root,double wt)
{
    if(root->left!=NULL)postOrderTraverse(f,root->left);
    if(root->right!=NULL)postOrderTraverse(f,root->right);
    f(root->val,wt);
}
template<typename type>
void binaryTree<type>::inOrderTraverse(void (*f)(type,double),node<type>*root,double wt)
{
    if(root->left!=NULL)inOrderTraverse(f,root->left);
    f(root->val,wt);
    if(root->right!=NULL)inOrderTraverse(f,root->right);
}
template<typename type>
void visit(type val,double wt)
{
    if(!(wt<0.000001&&-wt<0.000001)){
        cout<<wt<<' ';
    }
    cout<<val<<' ';
}
template<typename type>
void binaryTree<type>::level_visit()
{
    int sz = 50;
    typedef node<type>*  pt;
    pt a[sz],*tail =a,*head  = a;
    *(tail++)=root;
    while(head!=tail){
        cout<<(*head)->val<<' ';
        if((*head)->left!=NULL)*(tail++) = (*head)->left;
        if(tail-a>sz)tail-=sz;
        if((*head)->right!=NULL)*(tail++) = (*head)->right;
        if(tail-a>sz)tail-=sz;
        ++head;
        if(head-a>sz)head-=sz;
    }
}
template<typename type>
void  binaryTree<type>::swap()
{
    l_r(root);
}
template<typename type>
void binaryTree<type>::l_r(node<type> *rt)
{
    if(rt->left==NULL && rt->right==NULL){
        return;
    }
    if(rt->left==NULL && rt->right!=NULL){
        rt->left=rt->right;
        rt->right=NULL;
        l_r(rt->left);
    }
    else if(rt->left!=NULL && rt->right==NULL){
        rt->right=rt->left;
        rt->left=NULL;
        l_r(rt->right);
    }
    else{
        node<type> * tmp = rt->left;
        rt->left=rt->right;
        rt->right=tmp;
        l_r(rt->left);
        l_r(rt->right);
    }
}
template<typename type>
node<type>* binaryTree<type>::parent(type x)
{
    node<type> * a[num],**first=a,**last=a;
    if(root->val == x){
        cout<<"Doesn't find!!!"<<endl;
        return NULL;
    }
    *(last++) = root;
    while(first!=last){
        node<type> *cur = *(first++);
        if(cur->left!=NULL){
            if(cur->left->val!=x)*(last++) = cur->left;
            else return cur;
        }
        if(cur->right!=NULL){
            if(cur->right->val!=x)*(last++) = cur->right;
            else return cur;
        }
    }
    cout<<"Doesn't find!"<<endl;
    return NULL;
}
template<typename type>
node<type>* binaryTree<type>::self(type x)
{
    if(root->val == x)return root;
    node<type> *rst = &parent(x);
    if(rst==root)return NULL;
    if(rst->left!=NULL &&rst->left->val == x)return (rst->left);
    return (rst->right);
}
template<typename type>
node<type>* binaryTree<type>::delChild(type x)
{
    if(root->val==x){
        freeMem(root);
        root=NULL;
    }
    else{
        node<type> *rst = parent(x);
        if(rst==root){
            freeMem(root);
            root=NULL;
        }
        else if(rst->left!=NULL &&rst->left->val == x){
            freeMem(rst->left);
            rst->left=NULL;
        }
        else {
            freeMem(rst->right);
            rst->right=NULL;
        }
    }
    return root;
}
template<typename type>
node<type>* binaryTree<type>::insertChild(type x,node<type> *child,char dir)
{
    node<type>* rt=self(x);
    if(!rt){
        cout<<"insert failed!"<<endl;
        return root;
    }
    if(dir=='l'){
        if(rt->left!=NULL){
            freeMem(rt->left);
        }
        rt->left = child;
    }
    else{
        if(rt->right!=NULL){
            freeMem(rt->right);
        }
        rt->right = child;
    }
    return root;
}
template<typename type>
void  binaryTree<type>::freeMem(node<type>* root)
{
    if(root == NULL)return;
    freeMem(root->left);
    freeMem(root->right);
    delete root;
}
template<typename type>
void binaryTree<type>::display()
{
    cout<<"height:"<<height<<endl;
    cout<<"leaves:"<<leaves<<endl;;
    cout<<"total nodes:"<<num<<endl;;
    cout<<"preOrderTraverse-->";
    preOrderTraverse(visit,root);
    cout<<"\ninOrderTraverse-->";
    inOrderTraverse(visit,root);
    cout<<"\npostOrderTraverse-->";
    postOrderTraverse(visit,root);
    cout<<"\nlevel_visit:";
    level_visit();
}
int main()
{
    binaryTree<char> t(string("abdf##g##e#h##c##"));
    t.swap();
    //binaryTree<int> t(string("3 4#5##7##"));
//    cout<<"e's parent->"<<t.parent('e')->val<<endl;
//    t.delChild('d');
    binaryTree<char> cp(t),cp2=t;
    cp.display();
    cp2.display();
    return 0;
}
