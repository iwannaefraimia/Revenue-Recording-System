package omadiki5;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * UserDAO provides all the necessary methods related to users.
 * 
 * @author
 *
 */
public class UserDAO {


	// Method to return a List with all Users
	// @return List<User>
	public List<User> getUsers() throws Exception {

		List<User> list = new ArrayList<>();
		DB db = new DB();
		PreparedStatement stmt = null;
		Connection con = null;
		ResultSet rs;
		String query = "SELECT * FROM users;";
		try {
			con = db.getConnection();
			stmt = con.prepareStatement(query);
			rs = stmt.executeQuery();
			while (rs.next()) {
				User user = new User(rs.getString("username"), rs.getString("password"), rs.getString("fullname"),
						rs.getString("email"), rs.getString("phone"));
				list.add(user);
			}
			rs.close();
			stmt.close();
			return list;

		} catch (Exception e) {
			throw new Exception(e.getMessage());

		} finally {
			if (con != null) {
				db.close();
			}
		}

	} // End of getUsers





	// methos to search user by username
	// @param username, String
	// @return User, the User object or null
	// @throws Exception
	public User findUser(String username) throws Exception {

		DB db = new DB();
		Connection con = null;
		String query = "SELECT * FROM users WHERE username = ?;";
		try {

			con = db.getConnection();
			PreparedStatement stmt = con.prepareStatement(query);

			stmt.setString(1, username);

			ResultSet rs = stmt.executeQuery();

			if (!rs.next()) {
				rs.close();
				stmt.close();
				return null;

			}

			return new User(rs.getString("username"),
					rs.getString("password"),
					rs.getString("fullname"),
					rs.getString("email"),
					rs.getString("phone"));

		} catch (Exception e) {
			throw new Exception(e.getMessage());
		} finally {
			try {
				db.close();
			} catch (Exception e) {

			}
		}

	} // End of findUser






	// Method to authenticate a user.
 	// @param username, String
	// @param password, String
	// @return User, the User object
	// @throws Exception, if the credentials are not valid
	public User authenticate(String username, String password) throws Exception {

		DB db = new DB();
		PreparedStatement stmt = null;
		Connection con = null;
		ResultSet rs;
		String query = "SELECT * FROM users WHERE username = ? AND password = ?;";
		try {
			con = db.getConnection();
			stmt = con.prepareStatement(query);
			stmt.setString(1, username);
			stmt.setString(2, password);
			rs = stmt.executeQuery();

			if (!rs.next()) {
				rs.close();
				stmt.close();
				db.close();
				throw new Exception("Wrong username or password");
			}

			// Extra check if the account is activated
			if (rs.getString("activate").equals("0")) {
				rs.close();
				stmt.close();
				db.close();
				throw new Exception("Ο λογαριασμός σας (user account) δεν έχει ενεργοποιηθεί<br>(για λόγους ασφαλείας) από το διαχειριστή του συστήματος!<br>Παρακαλώ επικοινωνήστε μαζί του, προκειμένου να σας παραχωρήσει πρόσβαση στο σύστημα");
			}


			User user = new User(rs.getString("username"), rs.getString("password"), rs.getString("fullname"),
					rs.getString("email"), rs.getString("phone"));

			rs.close();
			stmt.close();
			return user;

		} catch (Exception e) {
			throw new Exception(e.getMessage());

		} finally {

			try {
				db.close();
			} catch (Exception e) {

			}
		}

	} // End of authenticate




	
	// method to register/create a new User.
	// @param user, User
	// @throws Exception, if encounter any error.
	public void register(User user) throws Exception {

		int count = 0;
		DB db = new DB();
		Connection con = null;
		String query = "SELECT count(*) FROM users WHERE username = ? OR email = ?;";

		try {
			con = db.getConnection();
			PreparedStatement stmt = con.prepareStatement(query);
			stmt.setString(1, user.getUsername());
			stmt.setString(2, user.getEmail());
			try (ResultSet rs = stmt.executeQuery()) {
				rs.next();
				count = rs.getInt(1);
				if (count > 0) {
					rs.close();
					stmt.close();
					throw new Exception("Sorry, username or email already registered");
				}
			}

			PreparedStatement stmt1 = null;
			String query1 = "INSERT INTO users (username, password, fullname, email, phone) VALUES (?,?,?,?,?)";
			try {
				stmt1 = con.prepareStatement(query1);
				stmt1.setString(1, user.getUsername());
				stmt1.setString(2, user.getPassword());
				stmt1.setString(3, user.getFullname());
				stmt1.setString(4, user.getEmail());
				stmt1.setString(5, user.getPhone());
				stmt1.executeUpdate();
				stmt1.close();

			} catch (SQLException e) {
				throw new Exception(e.getMessage());
			}

		} catch (Exception e) {
			throw new Exception(e.getMessage());

		} finally {

			try {
				db.close();
			} catch (Exception e) {

			}
		}

	}// end of register





	// Method to edit the details of an already registered User.
	public void updateDetails(User user) throws Exception {

		DB db = new DB();
		Connection con = null;
		String sql = "UPDATE users SET fullname = ?, email = ?, phone = ? WHERE username = ?";

		try {
			
			con = db.getConnection();
			PreparedStatement stmt = con.prepareStatement(sql);
			try {
				stmt.setString(1, user.getFullname());
				stmt.setString(2, user.getEmail());
				stmt.setString(3, user.getPhone());
				stmt.setString(4, user.getUsername());

				stmt.executeUpdate();
				stmt.close();

			} catch (SQLException e) {
				throw new Exception(e.getMessage());
			}

		} catch (Exception e) {
			throw new Exception(e.getMessage());

		} finally {

			try {
				db.close();
			} catch (Exception e) {

			}
		}

	}// end of updateDetails




	// Method to change the password of an already registered User.
	public void updatePassword(User user) throws Exception {

		DB db = new DB();
		Connection con = null;
		String sql = "UPDATE accounts SET password = ? WHERE username = ?";

		try {
			con = db.getConnection();
			con.setAutoCommit(true);

			PreparedStatement stmt = con.prepareStatement(sql);
			
			try {
				stmt.setString(1, user.getPassword());
				stmt.setString(2, user.getUsername());

				int userUpdated = stmt.executeUpdate();
				con.commit();
				System.out.println(userUpdated + " password updated.");

			} catch (SQLException e) {
				con.rollback();
            	throw new Exception("Error updating password: " + e.getMessage());
			} finally {
				stmt.close();
			}

		} catch (Exception e) {
			throw new Exception("Error establishing connection: " + e.getMessage());
    	} finally {

			try {
				db.close();
			} catch (Exception e) {

			}
		}

	}// end of updatePassword






} // End of class
