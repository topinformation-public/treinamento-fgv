trigger Accounts on Account ( after insert, after update ) {
    new AccountTH().run();
}