#pragma once 

#include <QTimer>

#include "DatagramListener.h"

class ServerAddressProvider 
	: public QObject
	, public IDataConsumer {
	Q_OBJECT
	
public:
	ServerAddressProvider() = default;

	Q_PROPERTY(int port READ getPort WRITE setPort NOTIFY portChanged);
	Q_PROPERTY(QString address READ getAddress NOTIFY addressFound)

	Q_INVOKABLE void find();

	quint16 getPort() const;
	void setPort(quint16 port);

	QString getAddress() const;

	//IDataConsumer
	void TakeData(QByteArray data) override;

signals:
	void addressFound();
	void portChanged();

private:
	bool CheckAddress(const QString& address);

private:
	DatagramListener m_listener;
	QString m_address = "";
};
