package lt.bta.java2.session;

import lt.bta.java2.model.CartItem;

import java.util.ArrayList;
import java.util.List;

public class Data {

    private boolean logged;

    private Integer userId;

    private String username;

    private Integer cartId;

    private List<CartItem> cartItemList = new ArrayList<>();

    public void clear() {
        logged = false;
        userId = null;
        username = null;
        cartId = null;
        cartItemList.clear();
    }

    public boolean isLogged() {
        return logged;
    }

    public void setLogged(boolean logged) {
        this.logged = logged;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Integer getCartId() {
        return cartId;
    }

    public void setCartId(Integer cartId) {
        this.cartId = cartId;
    }

    public List<CartItem> getCartItemList() {
        return cartItemList;
    }

    public void setCartItemList(List<CartItem> cartItemList) {
        this.cartItemList = cartItemList;
    }
}
