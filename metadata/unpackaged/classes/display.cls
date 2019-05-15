public class display {
private final Account acct;
public display(ApexPages.StandardController controller) {
this.acct = (Account)controller.getRecord();
}
public String getTitle() {
return 'Account: ' + acct.name + ' (' + acct.id + ')';
}
}