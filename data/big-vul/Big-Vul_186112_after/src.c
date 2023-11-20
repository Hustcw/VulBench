  void CallbackAndDie(bool succeeded) {
    // Use PostTask to avoid running user scripts while handling this
    // DidFailProvisionalLoad notification.
    base::MessageLoop::current()->PostTask(FROM_HERE,
                                           base::Bind(callback_, false));
     delete this;
   }
