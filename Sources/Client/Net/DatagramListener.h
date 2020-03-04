#pragma once

#include <QUdpSocket>
#include <QByteArray>

struct IDataConsumer 
{
	virtual bool ValidateData(QByteArray& data) = 0;
};

class DatagramListener : public QObject {
	Q_OBJECT
public:
	DatagramListener(quint16 port, IDataConsumer* consumer);

	void Start();
	bool IsInProgress() const;

private:
	void ProcessDatagrams();

private:
	bool m_is_in_progress = false;
	IDataConsumer* m_consumer = nullptr;
	quint16 m_port = 0;
	QUdpSocket m_socket;
};
