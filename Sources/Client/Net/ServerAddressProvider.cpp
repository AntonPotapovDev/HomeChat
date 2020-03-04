#include "ServerAddressProvider.h"

void ServerAddressProvider::start() {
	m_listener.Start();
}

quint16 ServerAddressProvider::getPort() const {
	return m_listener.Port();
}

void ServerAddressProvider::setPort(quint16 port){
	if (port == m_listener.Port())
		return;

	m_listener.Stop();
	m_listener.Bind(port);
	emit portChanged();
}

QString ServerAddressProvider::getAddress() const {
	return m_address;
}

bool ServerAddressProvider::CheckAddress(const QString& address) {
	return true;
}

void ServerAddressProvider::TakeData(QByteArray data) {
	QString address(data);

	if (!CheckAddress(address))
		return;

	bool first_time = m_address == "";
	m_address = address;
	m_listener.Stop();

	if (first_time) 
		emit addressGot();
	emit addressChanged();
}
